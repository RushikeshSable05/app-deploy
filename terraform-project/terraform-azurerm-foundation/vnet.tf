# create vnet only if vnet_name provided
resource "azurerm_virtual_network" "this" {
  count               = var.deployment.vnet_name == null ? 0 : 1
  name                = var.deployment.vnet_name
  resource_group_name = try(azurerm_resource_group.this[0].name, var.deployment.rg_name)
  location            = coalesce(var.deployment.location, try(azurerm_resource_group.this[0].location, "eastus"))
  address_space       = var.deployment.vnet_address_space
}
