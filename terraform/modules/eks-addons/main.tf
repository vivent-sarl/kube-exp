resource "aws_eks_addon" "this" {
  for_each = var.eks_addons

  cluster_name  = var.cluster_name
  addon_name    = each.key
  addon_version = each.value.version

  configuration_values = try(each.value.configuration_values, null)
}