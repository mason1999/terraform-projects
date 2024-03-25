variable "task" {
  description = "(Required) The purpose of the vm. It will be used as part of the naming of resources."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group."
  type        = string
}

variable "location" {
  description = "(Optional) The location of all the resources."
  type        = string
  default     = "Australia East"
}

variable "virtual_network_address_space" {
  description = "(Required) A list of strings in CIDR range format."
  type        = list(string)
}

variable "subnet_address_space" {
  description = "(Required) A list of strings in CIDR range format. Must be valid within the listed virtual network CIDR ranges."
  type        = list(string)
}

variable "private_ip_address" {
  description = "(Required) The private IP address."
  type        = string
}

variable "public_ip_address_id" {
  description = "(Optional) The public IP address id associated with the VM. Use this for development purposes."
  type        = string
  default     = ""
}

variable "enable_ip_forwarding" {
  description = "(Optional) Flag indicating whether to enable IP forwarding. Defaults to false."
  type        = bool
  default     = false
}

variable "enable_ssh" {
  description = "(Optional) A flag indicating whether to enable a rule for SSH. Defaults to false"
  type        = bool
  default     = false
}
