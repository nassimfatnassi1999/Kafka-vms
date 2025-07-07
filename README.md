# Projet Infrastructure Kafka - Déploiement Automatisé

Ce projet permet de déployer une infrastructure complète Kafka avec :
- 1 VM Jumpbox
- 3 VMs brokers Kafka
- 1 VM Zookeeper
- Monitoring via Prometheus et Grafana
- Dashboard AKHQ pour Kafka

## Arborescence du projet

├── terraform-project/
│ └── Modules et configuration Terraform pour créer l'infrastructure
├── Ansible/
│ └── Playbooks et rôles Ansible pour configurer les VM
└── Dockercompose/
└── Fichiers Docker Compose pour le monitoring et AKHQ



## 🔧 Pour exécuter les scripts Terraform, vous devez créer un fichier terraform.tfvars.
```bash
resource_group_name         = "devoteamResourceGroup"
virtual_network_name        = "myVNet"
address_space               = ["10.0.0.0/16"]
subnet_name                 = "mySubnet"
subnet_prefix               = "10.0.1.0/24"
network_interface_name      = "myNic"
# Liste des noms de VM à créer (3 brokers Kafka + 1 Zookeeper)
vm_names                    = ["broker1", "broker2", "broker3", "zookeeper1"]
# Nom d’utilisateur administrateur des VMs
admin_username              = "admin_devoteam"
# 🔐 À personnaliser : définissez un mot de passe fort ici
password                    = "votreMotDePasseFortIci"
# 🔑 Chemin vers votre clé publique SSH (ex: /home/chaima/.ssh/id_rsa.pub)
ssh_public_key_path         = "/chemin/vers/cle_ssh_publique"
# 🔑 ID de votre abonnement Azure
subscription_id             = "votre-id-abonnement-azure"
# 📍 Région Azure de déploiement (ex : francecentral, westeurope)
location                    = "francecentral"
# Paramètres pour le sous-réseau Bastion (accès sécurisé via Bastion)
bastion_subnet_name         = "myBastionSubnet"
bastion_subnet_prefix       = "10.0.2.0/26"
# Paramètres du compte de stockage
storage_account_name        = "devoteamstorageaccount"
# Paramètres CosmosDB
cosmosdb_account_name       = "cosmosdb-devoteam"
cosmosdb_db_name            = "kafka-cluster"
# Préfixe pour le sous-réseau de la passerelle
gateway_subnet_prefix       = "10.0.3.0/24"

```


## 🚀 Installation d'Ansible
Exécutez les commandes suivantes pour installer Ansible sur votre système Ubuntu :
```bash
#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
ansible --version
```
## 🔹 Commandes Ansible Utiles
```bash
ansible-playbook -i kafka-zook.ini playbook-kafka-zook.yml --ssh-extra-args='-o StrictHostKeyChecking=no'

```
# 🐳 Installation de Docker
```bash
#!/bin/bash

# Mise à jour des dépôts
sudo apt-get update

# Installation des dépendances
sudo apt-get install -y ca-certificates curl

# Création du répertoire pour la clé GPG de Docker
sudo install -m 0755 -d /etc/apt/keyrings

# Téléchargement de la clé GPG de Docker
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Attribution des permissions à la clé
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Ajout du dépôt Docker aux sources Apt
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mise à jour des dépôts
sudo apt-get update

# Installation de Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

```
## 🔹Commandes Docker Utiles
```bash
docker-compose up -d
docker ps 
docker-compose logs
docker log id-container
```

## 📁 Transfert des fichiers vers la VM Jumpbox
```bash
# Transfert des fichiers Ansible
sudo scp -i ~/.ssh/id_rsa -r /home/nassim-engineer/Bureau/Architecture-VMs/Ansible/* \
admin_devoteam@adresse-ip-jumpbox:/home/admin_devoteam

## Transfert des fichiers Docker Compose
sudo scp -i ~/.ssh/id_rsa -r /home/nassim-engineer/Bureau/Architecture-VMs/Docker-compose/* \
admin_devoteam@adresse-ip-jumpbox:/home/admin_devoteam
```

# 🎯 Conclusion
Vous avez installé Ansible, Docker et AKHQ sur votre système Ubuntu. Vous pouvez maintenant gérer vos configurations et orchestrer vos services Kafka efficacement ! 🚀


