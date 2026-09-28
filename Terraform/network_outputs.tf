output "network_vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "network_subnet_id" {
  description = "ID of the subnet (used by the VM network interface and the NSG association)"
  value       = azurerm_subnet.subnet.id
}