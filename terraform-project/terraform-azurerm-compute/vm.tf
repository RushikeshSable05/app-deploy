resource "azurerm_linux_virtual_machine" "this" {
  name                = var.deployment.vm_name
  resource_group_name = var.deployment.rg_name
  location            = var.deployment.location
  size                = var.deployment.vm_size
  admin_username      = var.deployment.admin_username
  network_interface_ids = [ azurerm_network_interface.this.id ]

  admin_ssh_key {
    username   = var.deployment.admin_username
    public_key = file(var.deployment.admin_ssh_key_path)
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

os_disk {
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
}
  tags = var.deployment.tags
}
