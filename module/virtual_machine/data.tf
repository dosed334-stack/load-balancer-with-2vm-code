data "azurerm_network_interface" "nic_data" {
  name                = var.nic_name
  resource_group_name = var.rg_name
}