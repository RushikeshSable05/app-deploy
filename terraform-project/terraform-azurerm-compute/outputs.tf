output "vm_ids" {
  value = try({ for k, v in azurerm_linux_virtual_machine.this : k => v.id }, {})
}

output "nic_ids" {
  value = try({ for k, v in azurerm_network_interface.this : k => v.id }, {})
}

output "osdisk_ids" {
  value = try({ for k, v in azurerm_managed_disk.osdisk : k => v.id }, {})
}
