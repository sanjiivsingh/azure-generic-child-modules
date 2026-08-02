resource_groups = {
  rg1 = {
    name     = "rg-dev-01"
    location = "central india"
  }
  rg2 = {
    name     = "rg-dev-02"
    location = "central india"
  }
}

virtual_networks = {
  vnet1 = {
    name                = "vnet-dev-01"
    location            = "central india"
    resource_group_name = "rg-dev-01"
    address_space       = ["10.0.0.0/16"]
  }
}