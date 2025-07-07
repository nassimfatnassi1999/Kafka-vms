output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
output "subnet_id" {
  value = azurerm_subnet.subnet.id
}
output "bastion_subnet_id" {
  value = azurerm_subnet.subnet_bastion.id
}