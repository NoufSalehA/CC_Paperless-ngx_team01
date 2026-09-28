resource "azurerm_network_security_group" "paperless_nsg"{
  name                = var.nsg_name
  location            = azurerm_resource_group.rg.location 
  resource_group_name = azurerm_resource_group.rg.name 
}

resource "azurerm_network_security_rule"  "paperless_nsg"{
  name                        = var.ssh_rule_name

  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"

  source_port_range           = "*"
  destination_port_range      = "22"

  source_address_prefix       = "*"
  destination_address_prefix  = "*"

  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.paperless_nsg.name

}

resource "azurerm_network_security_rule" "paperless_web" {
  name = var.web_rule_name

  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"

  source_port_range           = "*"
  destination_port_range      = var.paperless_port

  source_address_prefix       = "*"
  destination_address_prefix  = "*"

  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.paperless_nsg.name
}


# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "paperless_nsg" {
  network_interface_id      = azurerm_network_interface.paperless_nic.id
  network_security_group_id = azurerm_network_security_group.paperless_nsg.id
}