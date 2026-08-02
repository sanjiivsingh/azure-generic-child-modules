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

subnets = {
  subnet1 = {
    name                 = "frontend-subnet"
    resource_group_name  = "rg-dev-01"
    virtual_network_name = "vnet-dev-01"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "backend-subnet"
    resource_group_name  = "rg-dev-01"
    virtual_network_name = "vnet-dev-01"
    address_prefixes     = ["10.0.2.0/24"]
} }

public_ips = {
  pip1 = {
    name                = "pip-nic-frontend"
    resource_group_name = "rg-dev-01"
    location            = "central india"
    allocation_method   = "Static"
  }
  pip2 = {
    name                = "pip-nic-backend"
    resource_group_name = "rg-dev-01"
    location            = "central india"
    allocation_method   = "Static"
  }
}

nsgs = {
  nsg1 = {
    name                = "nsg-dev-01"
    location            = "central india"
    resource_group_name = "rg-dev-01"
    security_rule = {
      ssh = {
        priority               = "100"
        destination_port_range = "22"
      }
      http = {
        priority               = "110"
        destination_port_range = "80"
      }
    }
  }
  nsg2 = {
    name                = "nsg-dev-02"
    location            = "central india"
    resource_group_name = "rg-dev-01"
    security_rule = {
      ssh = {
        priority               = "100"
        destination_port_range = "22"
      }
    }
  }
}

nics = {
  nic1 = {
    name                 = "nic-dev-01"
    location             = "central india"
    resource_group_name  = "rg-dev-01"
    public_ip_name       = "pip-nic-frontend"
    subnet_name          = "frontend-subnet"
    virtual_network_name = "vnet-dev-01"
  }
  nic2 = {
    name                 = "nic-dev-02"
    location             = "central india"
    resource_group_name  = "rg-dev-01"
    public_ip_name       = "pip-nic-backend"
    subnet_name          = "backend-subnet"
    virtual_network_name = "vnet-dev-01"
} }

nsg_associations = {
  nsg_s1 = {
    nsg_name             = "nsg-dev-01"
    resource_group_name  = "rg-dev-01"
    subnet_name          = "frontend-subnet"
    virtual_network_name = "vnet-dev-01"
  }
  nsg_s2 = {
    nsg_name             = "nsg-dev-02"
    resource_group_name  = "rg-dev-01"
    subnet_name          = "backend-subnet"
    virtual_network_name = "vnet-dev-01"
} }

virtual_machines = {
  vm1 = {
    name                = "frontend-vm"
    resource_group_name = "rg-dev-01"
    location            = "central india"
    size                = "Standard_D2s_v3"

    nic_name            = "nic-dev-01"
    key_vault_name      ="key-vault-demo-1"
    kv_resource_group_name="rg-dev"
    admin_username      = "vm-username"
    admin_password      = "vm-password"  
    }
  vm2 = {
    name                = "backend-vm"
    resource_group_name = "rg-dev-01"
    location            = "central india"
    size                = "Standard_D2s_v3"
    nic_name            = "nic-dev-02"
    key_vault_name      ="key-vault-demo-1"
    kv_resource_group_name="rg-dev"
    admin_username      = "vm-username"
    admin_password      = "vm-password"} }
