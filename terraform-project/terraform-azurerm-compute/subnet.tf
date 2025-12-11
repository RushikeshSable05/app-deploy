resource "azurerm_subnet" "this" {
  name                 = var.deployment.subnet_name
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.deployment.subnet_prefix]
}
