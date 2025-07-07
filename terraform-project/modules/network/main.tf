resource "azurerm_resource_group" "network" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = var.address_space
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_prefix]
}
resource "azurerm_subnet" "subnet_bastion" {
  name                 = var.bastion_subnet_name
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.bastion_subnet_prefix] 
}


resource "azurerm_network_security_group" "NSG-Inbound" {
  name                = "acceptanceSecurityGroupInbound"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name

  security_rule {
    name                       = "ssh-allow-inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.bastion_subnet_prefix #bastion subnet
    destination_address_prefix = var.subnet_prefix #subnet
  }

}
resource "azurerm_network_security_group" "NSG-Outbound" {
  name                = "acceptanceSecurityGroupOutbound"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name

  security_rule {
    name                       = "ssh-allow"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.subnet_prefix #subnet
    destination_address_prefix = var.bastion_subnet_prefix #bastion subnet 
  }

}


resource "azurerm_network_security_group" "akhq-allow" {
  name                = "akhq-allow"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  security_rule {
    name                       = "akhq-allow-http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = var.bastion_subnet_prefix 
  }
  
}

resource "azurerm_network_security_group" "allow-kafka-zookeeper" {
  name                = "kafka-and-zookeeper"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name

  security_rule {
    name                       = "Allow-Zookeeper-2181-Inbound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2181"
    source_address_prefix      = var.bastion_subnet_prefix
    destination_address_prefix = var.subnet_prefix
  }
  security_rule {
    name                       = "Allow-Zookeeper-2181-Outbound"
    priority                   = 111
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2181"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow-Kafka-9092-Inbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9092"
    source_address_prefix      = var.bastion_subnet_prefix
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow-Kafka-9092-Outbound"
    priority                   = 121
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9092"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow-Zookeeper-2888-Inbound"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2888"
    source_address_prefix      = var.bastion_subnet_prefix
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow-Zookeeper-2888-Outbound"
    priority                   = 131
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "2888"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow-Zookeeper-3888-Inbound"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3888"
    source_address_prefix      = var.bastion_subnet_prefix
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow-Zookeeper-3888-Outbound"
    priority                   = 141
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3888"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_security_group" "allow-Exporters" {
  name                = "allow-exporters"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  
  security_rule {
    name                       = "jmx-exporter-allow-inbound"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "7071"
    source_address_prefix      = "*"
    destination_address_prefix = var.bastion_subnet_prefix
  }

  security_rule {
    name                       = "jmx-exporter-allow-outbound"
    priority                   = 106
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "7071"
    source_address_prefix      = var.bastion_subnet_prefix
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "jmx-exporter-allow-inbound-72"
    priority                   = 107
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "7072"
    source_address_prefix      = "*"
    destination_address_prefix = var.bastion_subnet_prefix
  }

  security_rule {
    name                       = "jmx-exporter-allow-outbound-72"
    priority                   = 108
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "7072"
    source_address_prefix      = var.bastion_subnet_prefix
    destination_address_prefix = "*"
  }
   security_rule {
    name                       = "kafka-exporter-allow-inbound"
    priority                   = 114
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9308"
    source_address_prefix      = "*"
    destination_address_prefix = var.bastion_subnet_prefix
  }

  security_rule {
    name                       = "kafka-exporter-allow-outbound"
    priority                   = 115
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9308"
    source_address_prefix      = var.bastion_subnet_prefix
    destination_address_prefix = "*"
  }
}

