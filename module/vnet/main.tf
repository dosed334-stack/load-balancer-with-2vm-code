resource "azurerm_virtual_network" "vnet21" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.vnet_location
  resource_group_name = var.rg_name
}