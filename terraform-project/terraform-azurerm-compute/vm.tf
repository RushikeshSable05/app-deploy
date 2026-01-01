# ============================================
# LINUX VIRTUAL MACHINE - Create for each VM
# ============================================


resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.deployment.compute.vms
  
  name                = each.key
  resource_group_name = var.foundation.resource_group.name
  location            = var.foundation.resource_group.location
  size                = each.value.size
  
  admin_username                  = each.value.admin_username
  disable_password_authentication = true
  
  admin_ssh_key {
    username   = each.value.admin_username
    public_key = file(each.value.ssh_public_key_path)
  }
  
  network_interface_ids = [
    azurerm_network_interface.vm[each.key].id
  ]
  
  os_disk {
    name                 = "${each.key}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = each.value.os_disk_type
    disk_size_gb         = each.value.os_disk_size_gb
  }
  
  source_image_reference {
    publisher = each.value.image.publisher
    offer     = each.value.image.offer
    sku       = each.value.image.sku
    version   = each.value.image.version
  }
  
  tags = var.deployment.tags
}

# ============================================
# DATA DISKS - Create additional disks if defined
# ============================================

locals {
  # Flatten data disks configuration
  data_disks = flatten([
    for vm_name, vm_config in var.deployment.compute.vms : [
      for disk in coalesce(vm_config.data_disks, []) : {
        vm_name              = vm_name
        disk_name            = "${vm_name}-${disk.name}"
        disk_size_gb         = disk.disk_size_gb
        storage_account_type = disk.storage_account_type
        lun                  = disk.lun
      }
    ]
  ])
  
  data_disks_map = {
    for disk in local.data_disks : disk.disk_name => disk
  }
}

resource "azurerm_managed_disk" "data" {
  for_each = local.data_disks_map
  
  name                 = each.value.disk_name
  location             = var.foundation.resource_group.location
  resource_group_name  = var.foundation.resource_group.name
  storage_account_type = each.value.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = each.value.disk_size_gb
  
  tags = var.deployment.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "data" {
  for_each = local.data_disks_map
  
  managed_disk_id    = azurerm_managed_disk.data[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm[each.value.vm_name].id
  lun                = each.value.lun
  caching            = "ReadWrite"
}

# OUTPUT
output "virtual_machines" {
  description = "Virtual Machine details"
  value = {
    for k, v in azurerm_linux_virtual_machine.vm : k => {
      id                 = v.id
      name               = v.name
      private_ip_address = v.private_ip_address
      public_ip_address  = try(azurerm_public_ip.vm[k].ip_address, null)
    }
  }
}

output "data_disks" {
  description = "Data disk details"
  value = {
    for k, v in azurerm_managed_disk.data : k => {
      id           = v.id
      name         = v.name
      disk_size_gb = v.disk_size_gb
    }
  }
}
