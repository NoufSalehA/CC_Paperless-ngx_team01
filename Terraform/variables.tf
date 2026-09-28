variable "resource_group_name" {
  description = "Name of Resource Group in Azure"
  type        = string
  default     = "paperless_rg"
}

variable "location" {
  description = "Location of resource"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "environment(dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vm_name" {
  description = "virtual machine name"
  type        = string
  default     = "paperless-vm"
}

variable "vm_size" {
  description = "Virtual machine size"
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Admin username"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "ssh public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "allowed_ssh_ip" {
  description = "Public IP (CIDR) allowed to connect via SSH"
  type        = string
}

variable "os_disk_size_gb" {
  description = "Disk size in GB"
  type        = number
  default     = 64
}
