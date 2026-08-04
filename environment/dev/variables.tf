variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string))
  }))
}
variable "virtual_networks" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = optional(map(string))
  }))
}
variable "subnets" {
  type = map(object({
    name                 = string
    virtual_network_name = string
    resource_group_name  = string
    address_prefixes     = list(string)
  }))
}
variable "public_ips" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
  }))
}
variable "nsgs" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    security_rule = map(object({
      priority               = number
      destination_port_range = string
      })
    )
  }))
}
variable "nics" {
  type = map(object({
    name                 = string
    location             = string
    resource_group_name  = string
    public_ip_name       = string
    subnet_name          = string
    virtual_network_name = string
  }))
}
variable "nsg_associations" {
  type = map(object({
    nsg_name                  = string
    resource_group_name       = string
    subnet_name               = string
    virtual_network_name      = string
  }))
}
variable "virtual_machines" {
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
