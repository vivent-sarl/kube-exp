
variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.34"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "service_ipv4_cidr" {
  description = "CIDR block for Kubernetes services"
  type        = string
  default     = "10.100.0.0/16"
}

variable "endpoint_private_access" {
  description = "Enable private API endpoint"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public API endpoint"
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "CIDR blocks for public access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "eks_addons_pre_node" {
  description = "EKS addons configuration before creating node"
  type = map(object({
    version              = string
    configuration_values = optional(string, null)
  }))
  default = {}
}

variable "eks_addons_post_node" {
  description = "EKS addons configuration after creating node"
  type = map(object({
    version              = string
    configuration_values = optional(string, null)
  }))
  default = {}
}

variable "node_groups" {
  description = "Configuration for EKS node groups"
  type = map(object({
    instance_types  = list(string)
    ami_type        = optional(string, "AL2023_x86_64_STANDARD")
    capacity_type   = optional(string, "ON_DEMAND")
    disk_size       = optional(number, 20)
    desired_size    = number
    max_size        = number
    min_size        = number
    release_version = optional(string, null)
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}