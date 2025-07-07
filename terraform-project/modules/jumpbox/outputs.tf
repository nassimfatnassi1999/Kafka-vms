# Output pour l'IP publique de la Jumpbox
output "jumpbox_public_ip" {
  value = azurerm_public_ip.jumpbox.ip_address
  description = "L'adresse IP publique dynamique de la Jumpbox"
}