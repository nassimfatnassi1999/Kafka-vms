variable "virtual_network_name" {}
variable "subnet_name" {}
variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
}
variable "subnet_prefix" {}
variable "gateway_subnet_prefix" {}
variable "resource_group_name" {}
variable "location" {}
variable "bastion_subnet_name" {}
variable "bastion_subnet_prefix" {}
