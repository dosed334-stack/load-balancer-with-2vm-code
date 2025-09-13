resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = data.azurerm_network_interface.data_nic.id
  network_security_group_id = data.azurerm_network_security_group.data_nsg.id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_assosiation" {
  network_interface_id    = data.azurerm_network_interface.data_nic.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.data_pool.id
}