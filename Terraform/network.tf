resource "azurerm_virtual_network" "vnet" {
  name                = "paperless-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
}
resource "azurerm_subnet" "subnet" {
  name                 = "paperless-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefix

  lifecycle {
    precondition {
      condition = alltrue([
        for p in var.subnet_address_prefix :
        anytrue([
          for v in var.vnet_address_space :
          tonumber(split("/", p)[1]) >= tonumber(split("/", v)[1]) &&
          cidrhost("${cidrhost(p, 0)}/${split("/", v)[1]}", 0) == cidrhost(v, 0)
        ])
      ])
      error_message = "Every subnet_address_prefix must be inside one of the vnet_address_space ranges."
    }
  }
}