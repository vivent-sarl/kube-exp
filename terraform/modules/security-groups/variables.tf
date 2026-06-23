variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Security group for EKS cluster"
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster for tagging"
  type        = string
}

variable "tags" {
  description = "Additional tags for the security group"
  type        = map(string)
  default     = {}
}