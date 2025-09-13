resource "azurerm_lb" "lb21" {
  name                = var.lb_name
  location            = var.lb_location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = var.frontend_ip_config
    public_ip_address_id = data.azurerm_public_ip.data_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backendpool" {
  loadbalancer_id = azurerm_lb.lb21.id
  name            = var.backendpool_name
}

resource "azurerm_lb_probe" "lbprobe" {
  loadbalancer_id = azurerm_lb.lb21.id
  name            = var.lbprobe_name
  port            = 80
}

resource "azurerm_lb_rule" "lbrule" {
  loadbalancer_id                = azurerm_lb.lb21.id
  name                           = var.lbrule_name
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.frontend_ip_config
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.backendpool.id]
  probe_id = azurerm_lb_probe.lbprobe.id
}