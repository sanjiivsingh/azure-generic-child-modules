module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  config = var.resource_groups
}

module "virtual_network" {
  source     = "../../modules/azurerm_virtual_network"
  config     = var.virtual_networks
  depends_on = [module.resource_group]
}