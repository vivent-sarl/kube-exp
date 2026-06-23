variable "cluster_role_name" {
  description = "Name for the EKS cluster IAM role"
  type        = string
}

variable "node_role_name" {
  description = "Name for the EKS node IAM role"
  type        = string
}

variable "node_group_role_name" {
  description = "Name for the EKS node group IAM role"
  type        = string
}

variable "tags" {
  description = "Tags to apply to IAM roles"
  type        = map(string)
  default     = {}
}