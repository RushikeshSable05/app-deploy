# create subnet only if subnet_name provided
resource "azurerm_subnet" "this" {
  count                 = var.deployment.subnet_name == null ? 0 : 1
  name                  = var.deployment.subnet_name
  resource_group_name   = try(azurerm_resource_group.this[0].name, var.deployment.rg_name)
  virtual_network_name  = try(azurerm_virtual_network.this[0].name, var.deployment.vnet_name)
  address_prefixes      = [var.deployment.subnet_prefix]
}
