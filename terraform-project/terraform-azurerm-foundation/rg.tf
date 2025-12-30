# ============================================
# RESOURCE GROUP - Create or Use Existing
# ============================================

# Try to find existing Resource Group
data "azurerm_resource_group" "existing" {
  count = var.deployment.foundation.resource_group.create == false ? 1 : 0
  name  = var.deployment.foundation.resource_group.name
}

# Create new Resource Group if needed
resource "azurerm_resource_group" "new" {
  count    = var.deployment.foundation.resource_group.create == true ? 1 : 0
  name     = var.deployment.foundation.resource_group.name
  location = var.deployment.foundation.resource_group.location
  
  tags = var.deployment.tags
}

# ============================================
# OUTPUT - Resource Group details
# ============================================

output "resource_group" {
  description = "Resource Group details"
  value = {
    id       = var.deployment.foundation.resource_group.create ? azurerm_resource_group.new[0].id : data.azurerm_resource_group.existing[0].id
    name     = var.deployment.foundation.resource_group.create ? azurerm_resource_group.new[0].name : data.azurerm_resource_group.existing[0].name
    location = var.deployment.foundation.resource_group.create ? azurerm_resource_group.new[0].location : data.azurerm_resource_group.existing[0].location
  }
}