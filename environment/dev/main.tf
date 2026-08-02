module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  config = var.resource_groups
}

module "virtual_network" {
  source     = "../../modules/azurerm_virtual_network"
  config     = var.virtual_networks
  depends_on = [module.resource_group]
}

module "subnet" {
  source     = "../../modules/azurerm_subnet"
  config     = var.subnets
  depends_on = [module.virtual_network]
}

module "public_ip" {
  source     = "../../modules/azurerm_public_ip"
  config     = var.public_ips
  depends_on = [module.resource_group]
}

module "nsg" {
  source     = "../../modules/azurerm_nsg"
  config     = var.nsgs
  depends_on = [module.resource_group]
}

module "nic" {
  depends_on = [module.subnet, module.public_ip]
  source     = "../../modules/azurerm_network_interface"
  config     = var.nics
}

module "nsg_association" {
  depends_on = [ module.nsg, module.subnet ]
  source = "../../modules/azurerm_nsg_subnet_association"
  config = var.nsg_associations
}