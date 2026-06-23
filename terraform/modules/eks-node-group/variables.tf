variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the node group"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for the node group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the node group"
  type        = list(string)
}

variable "instance_types" {
  description = "List of instance types for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "ami_type" {
  description = "Type of AMI for the node group"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "capacity_type" {
  description = "Capacity type (ON_DEMAND or SPOT)"
  type        = string
  default     = "ON_DEMAND"
}

variable "disk_size" {
  description = "Disk size in GB for worker nodes"
  type        = number
  default     = 20
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "node_repair_enabled" {
  description = "Enable automatic node repair"
  type        = bool
  default     = false
}

variable "max_unavailable" {
  description = "Maximum number of unavailable nodes during update"
  type        = number
  default     = 1
}

variable "kubernetes_version" {
  description = "Kubernetes version for the node group"
  type        = string
  default     = "1.34"
}

variable "release_version" {
  description = "AMI release version"
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags for the node group"
  type        = map(string)
  default     = {}
}