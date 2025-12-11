# find existing subnet created by foundation using names provided in deployment object
data "azurerm_subnet" "target" {
  name                 = var.deployment.subnet_name
  virtual_network_name = var.deployment.vnet_name
  resource_group_name  = var.deployment.rg_name
}
