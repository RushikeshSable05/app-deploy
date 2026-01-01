# ============================================
# PUBLIC IP - Create for each VM that needs it
# ============================================
# for_each explanation:
# - Loops through var.deployment.compute.vms
# - k = VM name (e.g., "200saprs1d001")
# - v = VM configuration object
# - Only creates Public IP if enable_public_ip = true

# ============================================
# PUBLIC IP - Create for each VM that needs it
# ============================================

resource "azurerm_public_ip" "vm" {
  for_each = {
    for k, v in var.deployment.compute.vms : k => v
    if v.enable_public_ip == true
  }
  
  name                = "${each.key}-pip"
  location            = var.foundation.resource_group.location
  resource_group_name = var.foundation.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
  
  tags = var.deployment.tags
}

# OUTPUT
output "public_ips" {
  description = "Public IP addresses"
  value = {
    for k, v in azurerm_public_ip.vm : k => {
      id         = v.id
      ip_address = v.ip_address
    }
  }
}