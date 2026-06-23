variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_addons" {
  description = "Map of EKS addons to install"
  type = map(object({
    version              = string
    configuration_values = optional(string)
  }))
  default = {}
}