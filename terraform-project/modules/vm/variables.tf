variable "resource_group_name" {}
variable "location" {}
variable "subnet_id" {}
variable "vm_size" {}
variable "admin_username" {}
variable "vm_names" {
  description = "The name of the virtual machine."
  type        = list(string)
}
variable "password" {
  description = "The password for the virtual machine."
  type        = string
  
}