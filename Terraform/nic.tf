variable "allowed_web_cidrs" {
  description = "List of CIDRs allowed to access the Paperless web interface"
  type        = list(string)

  validation {
    condition     = length(var.allowed_web_cidrs) > 0 && alltrue([for c in var.allowed_web_cidrs : can(cidrhost(c, 0))])
    error_message = "allowed_web_cidrs must be a non-empty list of valid CIDRs, e.g. [\"1.2.3.4/32\"]."
  }
}