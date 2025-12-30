# ============================================
# VIRTUAL NETWORK - Create or Use Existing
# ============================================

data "azurerm_virtual_network" "existing" {
  count               = var.deployment.foundation.vnet.create == false ? 1 : 0
  name                = var.deployment.foundation.vnet.name
  resource_group_name = var.deployment.foundation.resource_group.name
}

resource "azurerm_virtual_network" "new" {
  count               = var.deployment.foundation.vnet.create == true ? 1 : 0
  name                = var.deployment.foundation.vnet.name
  location            = var.deployment.foundation.resource_group.location
  resource_group_name = var.deployment.foundation.resource_group.name
  address_space       = [var.deployment.foundation.vnet.address_space]
  
  tags = var.deployment.tags
}

# OUTPUT
output "vnet" {
  description = "Virtual Network details"
  value = {
    id   = var.deployment.foundation.vnet.create ? azurerm_virtual_network.new[0].id : data.azurerm_virtual_network.existing[0].id
    name = var.deployment.foundation.vnet.create ? azurerm_virtual_network.new[0].name : data.azurerm_virtual_network.existing[0].name
    resource_group_name = var.deployment.foundation.resource_group.name
  }
}

# ============================================
# SUBNET - Create or Use Existing
# ============================================

data "azurerm_subnet" "existing" {
  count                = var.deployment.foundation.subnet.create == false ? 1 : 0
  name                 = var.deployment.foundation.subnet.name
  virtual_network_name = var.deployment.foundation.vnet.name
  resource_group_name  = var.deployment.foundation.resource_group.name
}

resource "azurerm_subnet" "new" {
  count                = var.deployment.foundation.subnet.create == true ? 1 : 0
  name                 = var.deployment.foundation.subnet.name
  resource_group_name  = var.deployment.foundation.resource_group.name
  virtual_network_name = var.deployment.foundation.vnet.name
  address_prefixes     = [var.deployment.foundation.subnet.address_prefix]
}

# OUTPUT
output "subnet" {
  description = "Subnet details"
  value = {
    id             = var.deployment.foundation.subnet.create ? azurerm_subnet.new[0].id : data.azurerm_subnet.existing[0].id
    name           = var.deployment.foundation.subnet.create ? azurerm_subnet.new[0].name : data.azurerm_subnet.existing[0].name
    address_prefix = var.deployment.foundation.subnet.create ? azurerm_subnet.new[0].address_prefixes[0] : data.azurerm_subnet.existing[0].address_prefixes[0]
  }
}