
resource "azurerm_linux_virtual_machine" "paperless_vm"{
  
  name                  = var.vm_name
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location 
  size                  = var.vm_size
  
  
  disable_password_authentication = false
  admin_username        = var.admin_username
  admin_password        = var.admin_password


  network_interface_ids = [
    azurerm_network_interface.paperless_nic.id 
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }


  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

}