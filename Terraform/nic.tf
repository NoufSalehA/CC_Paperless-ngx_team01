resource "azurerm_public_ip" "paperless_ip" {
  name                = "public-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

  sku = "Standard"
  
  tags = {
    environment = var.environment
  }
}


resource "azurerm_network_interface" "paperless_nic" {
  name                = "nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = azurerm_public_ip.paperless_ip.id
  }

  tags = {
    environment = var.environment
  }

}
