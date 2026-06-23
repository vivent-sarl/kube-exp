output "cluster_role_arn" {
  description = "ARN of the EKS cluster IAM role"
  value       = aws_iam_role.cluster_role.arn
}

output "node_role_arn" {
  description = "ARN of the EKS node IAM role"
  value       = aws_iam_role.node_role.arn
}

output "node_group_role_arn" {
  description = "ARN of the EKS node group IAM role"
  value       = aws_iam_role.node_group_role.arn
}

output "cluster_role_name" {
  description = "Name of the EKS cluster IAM role"
  value       = aws_iam_role.cluster_role.name
}

output "node_role_name" {
  description = "Name of the EKS node IAM role"
  value       = aws_iam_role.node_role.name
}

output "node_group_role_name" {
  description = "Name of the EKS node group IAM role"
  value       = aws_iam_role.node_group_role.name
}