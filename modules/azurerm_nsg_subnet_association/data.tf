data "azurerm_network_security_group" "this" {
    for_each = var.config
  name                = each.value.nsg_name
  resource_group_name = each.value.resource_group_name
}
data "azurerm_subnet" "this" {
  for_each             = var.config
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}