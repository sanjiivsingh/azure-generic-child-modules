# Azure Generic Child Modules

A collection of reusable and scalable Terraform child modules for provisioning Azure infrastructure following Infrastructure as Code (IaC) best practices.

This repository demonstrates how to build modular Azure infrastructure where each Azure resource is managed through an independent child module. The environment is driven entirely through `terraform.tfvars`, making deployments consistent, reusable, and easy to scale.

---

# Architecture

```
terraform.tfvars
        │
        ▼
Root Module
        │
        ├─────────────► Resource Group Module
        ├─────────────► Virtual Network Module
        ├─────────────► Subnet Module
        ├─────────────► Public IP Module
        ├─────────────► Network Security Group Module
        ├─────────────► NSG Association Module
        ├─────────────► Network Interface Module
        └─────────────► Linux Virtual Machine Module
```

Each module is completely independent and accepts its own configuration object.

---

# Repository Structure

```
.
├── environment/
│   └── dev/
│       ├── backend.tf
│       ├── provider.tf
│       ├── version.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       └── main.tf
│
├── modules/
│   ├── azurerm_resource_group/
│   ├── azurerm_virtual_network/
│   ├── azurerm_subnet/
│   ├── azurerm_public_ip/
│   ├── azurerm_network_interface/
│   ├── azurerm_nsg/
│   ├── azurerm_nsg_subnet_association/
│   └── azurerm_linux_virtual_machine/
│
└── README.md
```

---

# Modules

| Module | Purpose |
|---------|---------|
| Resource Group | Creates Azure Resource Groups |
| Virtual Network | Creates Virtual Networks |
| Subnet | Creates one or more subnets |
| Public IP | Creates Public IP Addresses |
| Network Security Group | Creates NSGs with dynamic security rules |
| NSG Association | Associates NSGs with subnets |
| Network Interface | Creates NICs with subnet and public IP association |
| Linux Virtual Machine | Creates Azure Linux VMs using Key Vault secrets |

---

# Features

- Modular Terraform Design
- Generic Child Modules
- Reusable Infrastructure
- Data-driven deployment using `terraform.tfvars`
- Dynamic NSG Security Rules
- Azure Key Vault Integration
- Supports Multiple Resources
- Easy Environment Separation
- Scalable Architecture

---

# Infrastructure Provisioned

Current sample deployment provisions

- 2 Resource Groups
- 1 Virtual Network
- 2 Subnets
- 2 Public IP Addresses
- 2 Network Security Groups
- NSG Associations
- 2 Network Interfaces
- 2 Linux Virtual Machines

---

# terraform.tfvars Structure

The complete infrastructure is defined inside `terraform.tfvars`.

Example:

```hcl
resource_groups = {
  rg1 = {
    name     = "rg-dev-01"
    location = "central india"
  }
}
```

Virtual Network

```hcl
virtual_networks = {
  vnet1 = {
    name                = "vnet-dev-01"
    address_space       = ["10.0.0.0/16"]
    resource_group_name = "rg-dev-01"
  }
}
```

Subnets

```hcl
subnets = {
  subnet1 = {
    name = "frontend-subnet"
  }
}
```

NSGs

```hcl
nsgs = {
  nsg1 = {
    security_rule = {
      ssh = {
        priority = 100
        destination_port_range = "22"
      }
    }
  }
}
```

Virtual Machines

```hcl
virtual_machines = {
  vm1 = {
    name = "frontend-vm"
    nic_name = "nic-dev-01"
    key_vault_name = "key-vault-demo-1"
  }
}
```

---

# Dynamic Security Rules

The NSG module uses Terraform Dynamic Blocks to generate security rules.

Example:

```
security_rule = {
    ssh = {
        priority = 100
        destination_port_range = "22"
    }

    http = {
        priority = 110
        destination_port_range = "80"
    }
}
```

Simply add another object and Terraform automatically creates the rule.

---

# Azure Key Vault Integration

The Virtual Machine module does not store credentials inside Terraform.

Instead it retrieves

- Admin Username
- Admin Password

using Azure Key Vault data sources.

```
Azure Key Vault
        │
        ▼
Terraform Data Sources
        │
        ▼
Linux Virtual Machine
```

This keeps credentials outside the codebase.

---

# Deployment

Initialize Terraform

```bash
terraform init
```

Validate

```bash
terraform validate
```

Format

```bash
terraform fmt -recursive
```

Plan

```bash
terraform plan
```

Apply

```bash
terraform apply
```

Destroy

```bash
terraform destroy
```

---

# Design Principles

- Child Module Architecture
- Generic Resource Definitions
- Reusable Infrastructure
- Separation of Environment and Modules
- Infrastructure as Code
- DRY (Don't Repeat Yourself)
- Parameterized Configuration
- Secure Secret Management
- Dynamic Blocks where required

---

# Future Enhancements

- Azure Bastion
- Azure Load Balancer
- NAT Gateway
- Azure Firewall
- Route Tables
- Managed Disks
- Availability Zones
- Availability Sets
- VM Scale Sets
- Azure Application Gateway
- Azure Monitor
- Log Analytics Workspace
- Diagnostic Settings
- GitHub Actions CI/CD
- Azure DevOps Pipeline
- Checkov Security Scan
- Infracost Integration

---

# Requirements

- Terraform >= 1.6
- AzureRM Provider
- Azure Subscription
- Azure CLI
- Azure Key Vault

---

# Author

**Sanjeev Singh**

DevOps | Azure | Terraform | GitHub Actions

Building reusable Azure Infrastructure modules using Terraform.

---