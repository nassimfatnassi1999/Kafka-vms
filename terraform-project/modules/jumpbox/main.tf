resource "azurerm_public_ip" "jumpbox" {
  name                = "jumpbox-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "time_sleep" "wait_for_ip" {
  create_duration = "60s"  # Ajuste la durée si nécessaire
  depends_on      = [azurerm_public_ip.jumpbox]
}
resource "azurerm_network_interface" "jumpbox_nic" {
  name                = "jumpbox-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.bastion_subnet_id  # Correctly point to your Bastion subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jumpbox.id
  }
}

resource "azurerm_linux_virtual_machine" "jumpbox" {
  name                = "jumpbox"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.jumpbox_nic.id]

  os_disk {
    name                 = "jumpbox-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }
}
