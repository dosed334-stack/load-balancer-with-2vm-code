module "resource_group" {
  source      = "../../module/resource_group"
  rg_name     = "shashi_rg"
  rg_location = "westus"
}

module "vnet" {
  source        = "../../module/vnet"
  depends_on    = [module.resource_group]
  vnet_name     = "shashi_vnet"
  vnet_location = "westus"
  rg_name       = "shashi_rg"
  address_space = ["10.0.0.0/16"]
}

module "azurerm_subnet" {
  source           = "../../module/subnet"
  depends_on       = [module.vnet]
  subnet_name      = "shashi_subnet"
  rg_name          = "shashi_rg"
  vnet_name        = "shashi_vnet"
  address_prefixes = ["10.0.1.0/24"]
}

module "azurerm_subnet2" {
  source           = "../../module/subnet"
  depends_on       = [module.vnet]
  subnet_name      = "shashi_subnet2"
  rg_name          = "shashi_rg"
  vnet_name        = "shashi_vnet"
  address_prefixes = ["10.0.2.0/24"]
}
module "azurerm_subnet_bastion" {
  source           = "../../module/subnet"
  depends_on       = [module.vnet]
  subnet_name      = "AzureBastionSubnet"
  rg_name          = "shashi_rg"
  vnet_name        = "shashi_vnet"
  address_prefixes = ["10.0.3.0/27"]
}


module "azurerm_public_ip" {
  source            = "../../module/public_ip"
  depends_on        = [module.resource_group]
  pip_name          = "shashi_lb_pip"
  pip_location      = "westus"
  rg_name           = "shashi_rg"
  allocation_method = "Static"
}
module "azurerm_public_ip_bastion" {
  source            = "../../module/public_ip"
  depends_on        = [module.resource_group]
  pip_name          = "shashi_bastion_pip"
  pip_location      = "westus"
  rg_name           = "shashi_rg"
  allocation_method = "Static"
}

module "azurerm_network_interface" {
  source       = "../../module/nic"
  depends_on   = [module.azurerm_subnet]
  nic_location = "westus"
  nic_name     = "shashi_nic"
  rg_name      = "shashi_rg"
  vnet_name    = "shashi_vnet"
  subnet_name  = "shashi_subnet"
}

module "azurerm_network_interface2" {
  source       = "../../module/nic"
  depends_on   = [module.azurerm_subnet2]
  nic_location = "westus"
  nic_name     = "shashi_nic2"
  rg_name      = "shashi_rg"
  vnet_name    = "shashi_vnet"
  subnet_name  = "shashi_subnet2"
}


module "azurerm_network_security_group" {
  source       = "../../module/nsg"
  depends_on   = [module.resource_group]
  nsg_name     = "shashi_nsg"
  nsg_location = "westus"
  rg_name      = "shashi_rg"
}

module "azurerm_network_security_group2" {
  source       = "../../module/nsg"
  depends_on   = [module.resource_group]
  nsg_name     = "shashi_nsg2"
  nsg_location = "westus"
  rg_name      = "shashi_rg"
}

module "azurerm_linux_virtual_machine" {
  source         = "../../module/virtual_machine"
  depends_on     = [module.azurerm_network_interface]
  vm_name        = "shashivm"
  vm_location    = "westus"
  rg_name        = "shashi_rg"
  admin_username = "shashiuser"
  admin_password = "Shashi@727262"
  nic_name       = "shashi_nic"
}

module "azurerm_linux_virtual_machine2" {
  source         = "../../module/virtual_machine"
  depends_on     = [module.azurerm_network_interface2]
  vm_name        = "shashivms"
  vm_location    = "westus"
  rg_name        = "shashi_rg"
  admin_username = "shashiuser"
  admin_password = "Shashi@727262"
  nic_name       = "shashi_nic2"
}

module "resource_azurerm_lb" {
  source             = "../../module/load_balancer"
  depends_on         = [module.azurerm_public_ip, module.resource_group]
  lb_name            = "shashi_lb"
  lb_location        = "westus"
  rg_name            = "shashi_rg"
  frontend_ip_config = "lb_ip"
  backendpool_name   = "lb_pool"
  lbprobe_name       = "lb_probe"
  lbrule_name        = "lb_rule"
  pip_name           = "shashi_lb_pip"
}


module "nic_assosiation" {
  source     = "../../module/nic_association"
  depends_on = [module.resource_group, module.resource_azurerm_lb]
  nic_name   = "shashi_nic"
  nsg_name   = "shashi_nsg"
  pool_name  = "lb_pool"
  rg_name    = "shashi_rg"
  lb_name    = "shashi_lb"
}

module "nic_assosiation2" {
  source     = "../../module/nic_association"
  depends_on = [module.resource_group, module.resource_azurerm_lb]
  nic_name   = "shashi_nic2"
  nsg_name   = "shashi_nsg2"
  pool_name  = "lb_pool"
  rg_name    = "shashi_rg"
  lb_name    = "shashi_lb"
}

module "bastion" {
    source = "../../module/bastion"
    depends_on = [module.resource_group ,module.azurerm_public_ip_bastion , module.azurerm_subnet_bastion  ]
    bastion_name = "shashi_bastion"
    bastion_location = "westus"
    rg_name = "shashi_rg"
    vnet_name = "shashi_vnet"
    pip_bastion_name = "shashi_bastion_pip"
  subnet_name = "AzureBastionSubnet"
  location = "westus"
}

# module "bastion_subnet" {
#   source = "../../module/subnet"
#   depends_on = [module.resource_group  ]
#   rg_name = "shashi_rg"
#   vnet_name = "shashi_vnet"
#   bastion_subnet_name = "AzureBastionSubnet"
#   address_prefixes = ["10.0.1.0/27"]
# }

# module "pip_bastion" {
#   source = "../../module/pip_bastion"
#   depends_on = [module.resource_group  ]
#   pip_name = "pip_bastion"
#   location = "westus"
#   rg_name = "shashi_rg"
# }