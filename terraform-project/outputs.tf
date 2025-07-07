
#afficher les infos de la cosmosdb
# output "cosmosdb_info" {
#   description = "Informations sur la base de données CosmosDB"
#   value       = module.cosmosdb
# }
# #afficher les infos du stockage blob
# output "blob_storage_info" {
#   description = "Informations sur le stockage Blob"
#   value       = module.blob_storage
# }
output "jumpbox_public_ip" {
  value = module.jumpbox.jumpbox_public_ip
  description = "L'adresse IP publique de la Jumpbox"
}

output "vm_private_ips" {
  value = module.vms.vm_private_ips
  description = "Les adresses IP privées des VMs"
}
