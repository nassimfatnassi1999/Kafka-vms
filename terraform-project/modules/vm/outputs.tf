# Afficher les adresses IP privées de chaque VM
output "vm_private_ips" {
  value = { for vm_name, vm_nic in azurerm_network_interface.vm_nic : vm_name => vm_nic.ip_configuration[0].private_ip_address }
  description = "Les adresses IP privées des VMs"
}