data "azurerm_public_ip" "this" {
  for_each            = var.config
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}
data "azurerm_subnet" "this" {
  for_each             = var.config
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}