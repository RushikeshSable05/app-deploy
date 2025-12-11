resource "azurerm_network_interface" "this" {
  name                = "${var.deployment.vm_name}-nic"
  resource_group_name = var.deployment.rg_name
  location            = var.deployment.location

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = data.azurerm_subnet.target.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = try(azurerm_public_ip.this[0].id, null)
  }

  tags = var.deployment.tags
}
