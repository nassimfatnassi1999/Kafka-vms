variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources."
  type        = string
  default     = "francecentral"
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "subnet_prefix" {
  description = "The address prefix for the subnet."
  type        = string
}
variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
}

variable "network_interface_name" {
  description = "The name of the network interface."
  type        = string
}

variable "vm_names" {
  description = "The name of the virtual machine."
  type        = list(string)
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key."
  type        = string
}
variable "gateway_subnet_prefix" {
  description = "The address prefix for the gateway subnet."
  type        = string
  
}
variable "bastion_subnet_prefix" {
  description = "The address prefix for the bastion subnet."
  type        = string
}

variable "storage_account_name" {
  description = "Blob storage account name"
}

variable "cosmosdb_account_name" {
  description = "Cosmos DB account name"
}

variable "cosmosdb_db_name" {
  description = "Cosmos DB database name"
}

variable "bastion_subnet_name" {}

variable "password" {
  description = "The password for the virtual machine."
  type        = string
  
}
