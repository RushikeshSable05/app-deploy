resource "azurerm_virtual_network" "this" {
  name                = var.deployment.vnet_name
  resource_group_name = azurerm_resource_group.this.name
  location            = var.deployment.location
  address_space       = var.deployment.vnet_address_space
}
