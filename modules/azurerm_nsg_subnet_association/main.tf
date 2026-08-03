resource "azurerm_subnet_network_security_group_association" "this" {
  for_each                  = var.config
  subnet_id                 = data.azurerm_subnet.this[each.key].id
  network_security_group_id = data.azurerm_network_security_group.this[each.key].id
}

