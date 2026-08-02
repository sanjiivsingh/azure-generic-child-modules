# Azure Generic Child Modules

Reusable Terraform child modules for common Azure resources and an example `dev` environment that composes them. This repository provides small, single-purpose modules you can combine to build infrastructure consistently across environments.

## What this is
A collection of opinionated, reusable Terraform child modules for Azure (resource group, virtual network, subnet, NSG, NIC, public IP, Linux VM, and associations) plus an example `environment/dev` overlay showing how to wire them together. It’s targeted at infrastructure engineers who want a modular starting point for Azure IaC.

## Features
- Small, single-responsibility Terraform modules (one resource type per module)
- Example environment configuration (environment/dev)
- Explicit var files for quick experiments
- Designed to be composable so you can pick and extend modules for your needs

## Stack
- Language: HCL (Terraform)
- Runtime: Terraform CLI (using the AzureRM provider)
- Notable providers / tooling: `azurerm` provider, Terraform state backend configured in `environment/dev/backend.tf`

---

## Repository layout
```
.gitignore
LICENSE
README.md

environment/                 # Example environment overlays
  dev/                       # Development environment example (backend, provider, main.tf, variables.tf, terraform.tfvars)

modules/                     # Reusable Terraform child modules
  azurerm_linux_virtual_machine/   # Linux VM module (main, data, variables)
  azurerm_network_interface/       # Network Interface module
  azurerm_nsg/                     # Network Security Group module
  azurerm_nsg_subnet_association/  # NSG to Subnet association module
  azurerm_public_ip/               # Public IP module
  azurerm_resource_group/          # Resource Group module
  azurerm_subnet/                  # Subnet module
  azurerm_virtual_network/         # Virtual Network module
```

How it fits together
- The `environment/dev` configuration composes the modules to create a minimally complete environment (resource group, vnet, subnet, nsg, nic, public ip, vm). Modules expose inputs and outputs so values can be passed between them from `environment/dev/main.tf`.

---

## How to run the example (dev)
Minimal steps to evaluate the dev environment locally (from a machine with Terraform installed and Azure credentials available):

1. Open a shell in the environment/dev directory:
   cd environment/dev

2. Authenticate to Azure (one of):
   - az login (interactive) — or
   - export ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID for service principal auth

3. Initialize Terraform and the configured backend:
   terraform init

4. See what will change:
   terraform plan -var-file="terraform.tfvars"

5. Apply the configuration:
   terraform apply -var-file="terraform.tfvars"

Notes and prerequisites:
- The environment/dev/backend.tf indicates a remote state backend is configured; ensure the backend storage (storage account/container or remote backend) is reachable and properly configured before applying.
- terraform.tfvars in environment/dev contains concrete variable values for the sample environment; review and update sensitive values and identifiers (subscription IDs, names, IPs) before applying.
- The AzureRM provider requires Azure authentication (az login or service principal). Ensure the principal has the required permissions to create the resources used by these modules.

---

## Example: using a module
Below is a minimal example of how a module in this repo can be called from a root module or environment overlay.

```hcl
module "example_rg" {
  source = "../modules/azurerm_resource_group"
  name   = "rg-example-dev"
  location = "eastus"
}

module "example_vnet" {
  source = "../modules/azurerm_virtual_network"
  name = "vnet-example"
  resource_group_name = module.example_rg.name
  address_space = ["10.0.0.0/16"]
}
```

Replace `source` with the relative path to the desired child module within this repo when composing locally (e.g., `../modules/<module_name>`).

---

## Modules (short reference)
Each module is intentionally small and focuses on a single Azure resource type. For full details, inspect the module files in `modules/<module_name>`.

- azurerm_resource_group — Creates an Azure resource group. Inputs: `name`, `location`. Outputs: `id`, `name`, `location`.
- azurerm_virtual_network — Creates an Azure virtual network. Inputs: `name`, `resource_group_name`, `address_space`. Outputs: `id`, `name`, `address_space`.
- azurerm_subnet — Creates a subnet in a given vnet. Inputs: `name`, `resource_group_name`, `virtual_network_name`, `address_prefix`. Outputs: `id`, `name`.
- azurerm_nsg — Creates a Network Security Group and default security rules. Inputs: `name`, `resource_group_name`, `security_rules` (optional). Outputs: `id`, `name`.
- azurerm_nsg_subnet_association — Associates an NSG to a subnet. Inputs: `nsg_id`, `subnet_id`.
- azurerm_public_ip — Creates a Public IP. Inputs: `name`, `resource_group_name`, `allocation_method`.
- azurerm_network_interface — Creates a NIC and attaches to subnet / optionally public IP. Inputs: `name`, `resource_group_name`, `subnet_id`, `public_ip_id` (optional). Outputs: `id`, `private_ip_address`, `public_ip_address` (if available).
- azurerm_linux_virtual_machine — Creates a Linux VM. Inputs typically include `name`, `resource_group_name`, `network_interface_ids`, `admin_username`, `admin_ssh_key` or password. Outputs: `id`, `public_ip`, `private_ip`.

If you’d like, I can add per-module README files that list full input/output variable docs and examples.

---

## Best practices & recommendations
- Keep modules small and focused — each module here follows that guideline. If you extend modules, aim to preserve a single responsibility.
- Use remote state locking for team workflows (the `environment/dev/backend.tf` shows backend usage) and protect state access.
- Add `terraform fmt` and `terraform validate` checks in CI to keep formatting and configuration consistent.

---

## Contributing
Contributions welcome. Typical contribution workflow:
1. Fork the repo
2. Create a feature branch
3. Run `terraform fmt` on changes and `terraform validate` in affected directories
4. Open a PR describing the change and include a short example if it affects module inputs/outputs

If you want me to add CI config (GitHub Actions) that runs `terraform fmt`/`terraform validate` and a plan job for the `environment/dev` folder, I can add that as a follow-up.

---

## License
This repository is released under the terms of the license in the `LICENSE` file.

---

If you’re happy with this README I will commit it to `README.md`. I can also:
- Add detailed per-module README files (inputs, outputs, examples)
- Create an examples/ folder with ready-to-run compositions
- Add GitHub Actions to run `terraform fmt` / `terraform validate` and `tflint` on PRs

Tell me which follow-up you'd like and I’ll add it next.