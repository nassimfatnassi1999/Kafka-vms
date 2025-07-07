resource "azurerm_network_interface" "vm_nic" {
  for_each            = toset(var.vm_names)
  name                = "${each.value}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = toset(var.vm_names)
  name                = each.value
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password = var.password 

   disable_password_authentication = false  

  network_interface_ids = [azurerm_network_interface.vm_nic[each.value].id]

  os_disk {
    name = "${each.value}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
   
 
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}