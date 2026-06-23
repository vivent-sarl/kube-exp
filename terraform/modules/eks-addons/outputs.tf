output "addon_arns" {
  description = "ARNs of the installed EKS addons"
  value       = { for k, v in aws_eks_addon.this : k => v.arn }
}

output "addon_ids" {
  description = "IDs of the installed EKS addons"
  value       = { for k, v in aws_eks_addon.this : k => v.id }
}