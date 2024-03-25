variable "subnet_id" {
  description = "(Required) The subnet ID."
  type        = string
}

variable "network_security_group_id" {
  description = "(Required) The network security group ID."
  type        = string
}

variable "network_security_group_name" {
  description = "(Required) The name of the network security group."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group."
  type        = string
}

variable "enable_ssh" {
  description = "(Optional) A flag indicating whether to enable a rule for SSH. Defaults to false"
  type        = bool
  default     = false
}
