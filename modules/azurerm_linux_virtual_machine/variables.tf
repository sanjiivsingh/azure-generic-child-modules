variable "config" {
  type = map(object({
    name                   = string
    resource_group_name    = string
    location               = string
    size                   = string
    nic_name               = string
    key_vault_name         = string
    kv_resource_group_name = string
    admin_username         = string
    admin_password         = string
  }))
}
