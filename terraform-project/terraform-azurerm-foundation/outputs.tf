output "rg_name" {
  description = "Resource group name (created or provided)"
  value       = try(azurerm_resource_group.this[0].name, var.deployment.rg_name, null)
}

output "rg_id" {
  description = "Resource group id"
  value       = try(azurerm_resource_group.this[0].id, null)
}

output "vnet_name" {
  description = "VNet name (created or provided)"
  value       = try(azurerm_virtual_network.this[0].name, var.deployment.vnet_name, null)
}

output "vnet_id" {
  description = "VNet id"
  value       = try(azurerm_virtual_network.this[0].id, null)
}

output "subnet_name" {
  description = "Subnet name (created or provided)"
  value       = try(azurerm_subnet.this[0].name, var.deployment.subnet_name, null)
}

output "subnet_id" {
  description = "Subnet id"
  value       = try(azurerm_subnet.this[0].id, null)
}
