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
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}


#NSG_varibels
variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
  default     = "paperless-nsg"
}

variable "ssh_rule_name" {
  description = "Name of the SSH security rule"
  type        = string
  default     = "Allow-SSH"
}

variable "web_rule_name" {
  description = "Name of the paperless web"
  type        = string
  default     = "Allow-Paperless-Web"
}

variable "paperless_port" {
  description = "Port Paperless-ngx"
  type        = string
  default     = "8000"
}


#vm
variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}