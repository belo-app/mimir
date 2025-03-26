variable "security_group_id" {
  description = "Destination Security Group ID where the rule will be applied"
  type        = string
}
variable "source_security_group_id" {
  description = "List of source Security Group IDs"
  type        = list(string)
  default     = []
}
variable "source_cidr_blocks" {
  description = "List of source CIDR blocks"
  type        = list(string)
  default     = []
}
variable "rule_type" {
  description = "Type of rule for the Security Group"
  type        = string
  default     = "ingress"
}
variable "port" {
  description = "Port to enable in the rule"
  type        = number
  default     = 22
}
variable "protocol" {
  description = "Protocol to enable in the rule"
  type        = string
  default     = "tcp"
}
