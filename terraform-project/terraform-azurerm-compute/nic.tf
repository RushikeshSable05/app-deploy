# ============================================
# NETWORK INTERFACE - Create for each VM
# ============================================
# for_each explanation:
# - Loops through ALL VMs in var.deployment.compute.vms
# - k = VM name
# - v = VM configuration

resource "azurerm_network_interface" "vm" {
  for_each = var.deployment.compute.vms
  
  name                = "${each.key}-nic"
  location            = var.foundation.resource_group.location
  resource_group_name = var.foundation.resource_group.name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.foundation.subnet.id
    private_ip_address_allocation = each.value.private_ip_address != null ? "Static" : "Dynamic"
    private_ip_address            = each.value.private_ip_address
    
    # Attach Public IP if it exists for this VM
    public_ip_address_id = try(azurerm_public_ip.vm[each.key].id, null)
  }
  
  tags = var.deployment.tags
}

# OUTPUT
output "network_interfaces" {
  description = "Network Interface details"
  value = {
    for k, v in azurerm_network_interface.vm : k => {
      id                 = v.id
      name               = v.name
      private_ip_address = v.private_ip_address
    }
  }
}