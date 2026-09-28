variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]

  validation {
    condition     = length(var.vnet_address_space) > 0 && alltrue([for c in var.vnet_address_space : can(cidrhost(c, 0))])
    error_message = "vnet_address_space must be a non-empty list of valid CIDR blocks, e.g. [\"10.0.0.0/16\"]."
  }
}

variable "subnet_address_prefix" {
  description = "Address prefix for the subnet (must be inside vnet_address_space)"
  type        = list(string)
  default     = ["10.0.1.0/24"]

  validation {
    condition     = length(var.subnet_address_prefix) > 0 && alltrue([for c in var.subnet_address_prefix : can(cidrhost(c, 0))])
    error_message = "subnet_address_prefix must be a non-empty list of valid CIDR blocks, e.g. [\"10.0.1.0/24\"]."
  }
}