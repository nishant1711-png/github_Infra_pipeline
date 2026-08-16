module "resource_group" {
  source = "../../Child_Modules/azurerm_resource_group"
  rgs    = var.rg_mod
}

module "virtual_network" {
  source     = "../../Child_Modules/azurerm_virtual_network"
  depends_on = [module.resource_group]
  vnets      = var.vnet_mod
}

module "subnet" {
  source     = "../../Child_Modules/azurerm_subnet"
  depends_on = [module.virtual_network]
  subnets    = var.snet_mod
}

module "virtual_machine" {
  source     = "../../Child_Modules/azurerm_virtual_machine"
  depends_on = [module.subnet]
  vms        = var.vms_mod
}

module "nsg" {
  source     = "../../Child_Modules/azurerm_network_security_group"
  depends_on = [module.subnet]
  nsgs       = var.nsg_mod
}