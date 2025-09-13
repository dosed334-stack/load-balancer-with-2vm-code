data "azurerm_network_interface" "data_nic" {
  name                = var.nic_name
  resource_group_name = var.rg_name
}

data "azurerm_lb" "data_lb" {
  name                = var.lb_name
  resource_group_name = var.rg_name
}

data "azurerm_lb_backend_address_pool" "data_pool" {
  name            = var.pool_name
  loadbalancer_id = data.azurerm_lb.data_lb.id
}

data "azurerm_network_security_group" "data_nsg" {
  name                = var.nsg_name
  resource_group_name = var.rg_name
}