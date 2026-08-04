variable "config" {
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
