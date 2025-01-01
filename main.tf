resource "azurerm_virtual_wan" "this" {
  name                = var.name
  resource_group_name = var.rg.name
  location            = var.rg.location
}

module "virtual_hubs" {
  source                     = "app.terraform.io/ptonini-org/virtual-hub/azurerm"
  version                    = "~> 1.0.0"
  for_each                   = var.virtual_hubs
  name                       = "${var.name}-${each.key}-hub"
  rg                         = var.rg
  virtual_wan_id             = azurerm_virtual_wan.this.id
  address_prefix             = each.value.address_prefix
  connections                = each.value.connections
  vpn_server_configurations  = each.value.vpn_server_configurations
  point_to_site_vpn_gateways = each.value.point_to_site_vpn_gateways
}