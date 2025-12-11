# create RG only if rg_name provided
resource "azurerm_resource_group" "this" {
  count    = var.deployment.rg_name == null ? 0 : 1
  name     = var.deployment.rg_name
  location = coalesce(var.deployment.location, "eastus")
  tags     = var.deployment.tags
}
