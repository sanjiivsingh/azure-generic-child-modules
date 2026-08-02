data "azurerm_network_interface" "this" {
  for_each            = var.config
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault" "this" {
  for_each            = var.config
  name                = each.value.key_vault_name
  resource_group_name = each.value.kv_resource_group_name
}
data "azurerm_key_vault_secret" "username" {
  for_each     = var.config
  name         = each.value.admin_username
  key_vault_id = data.azurerm_key_vault.this[each.key].id
}
data "azurerm_key_vault_secret" "password" {
  for_each     = var.config
  name         = each.value.admin_password
  key_vault_id = data.azurerm_key_vault.this[each.key].id
}
