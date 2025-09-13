data "azurerm_public_ip" "data_pip" {
  name                = var.pip_name
  resource_group_name = var.rg_name
}