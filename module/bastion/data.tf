data "azurerm_public_ip" "data_pip_bastion" {
  name                = var.pip_bastion_name
  resource_group_name = var.rg_name
}

data "azurerm_subnet" "data_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}