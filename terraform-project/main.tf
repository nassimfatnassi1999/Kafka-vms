# Module réseau
module "network" {
  source               = "./modules/network"
  resource_group_name  = var.resource_group_name
  location             = var.location
  virtual_network_name = var.virtual_network_name
  address_space        = var.address_space
  subnet_name          = var.subnet_name
  subnet_prefix        = var.subnet_prefix
  bastion_subnet_name  = var.bastion_subnet_name
  bastion_subnet_prefix = var.bastion_subnet_prefix
  gateway_subnet_prefix = var.gateway_subnet_prefix
}

module "vms" {
  source              = "./modules/vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.network.subnet_id
  admin_username      = var.admin_username
  password      = var.password
  vm_names            = var.vm_names  
  vm_size             = var.vm_size  

  depends_on = [module.network]  
}

module "jumpbox" {
  source              = "./modules/jumpbox"
  resource_group_name = var.resource_group_name
  location            = var.location
  bastion_subnet_id          = module.network.bastion_subnet_id
  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
  vm_names            = ["jumpbox"]  
  vm_size             = "Standard_B1s"
  subscription_id     = var.subscription_id
  network_interface_name = var.network_interface_name
  virtual_network_name = var.virtual_network_name
  subnet_name          = var.bastion_subnet_name
  subnet_prefix        = var.bastion_subnet_prefix
  depends_on = [module.vms, module.network]  
}

# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
# Availability Sets
# resource "azurerm_availability_set" "zookeeper" {
#   name                        = "zookeeper-avail-set"
#   location                    = var.location
#   resource_group_name         = var.resource_group_name
#   platform_fault_domain_count = 2
# }

# resource "azurerm_availability_set" "broker" {
#   name                        = "broker-avail-set"
#   location                    = var.location
#   resource_group_name         = var.resource_group_name
#   platform_fault_domain_count = 2
# }
# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

