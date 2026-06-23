locals {
  eks_policy_arn_prefix = "arn:aws:iam::aws:policy"

  cluster_role_policies = toset([
    "AmazonEKSBlockStoragePolicy",
    "AmazonEKSClusterPolicy",
    "AmazonEKSComputePolicy",
    "AmazonEKSLoadBalancingPolicy",
    "AmazonEKSNetworkingPolicy",
  ])

  node_role_policies = toset([
    "AmazonEKSWorkerNodeMinimalPolicy",
    "AmazonElasticContainerRegistryPublicReadOnly",
    "AmazonEC2ContainerRegistryPullOnly",
  ])

  node_group_role_policies = toset([
    "AmazonElasticContainerRegistryPublicReadOnly",
    "AmazonEKSWorkerNodePolicy",
    "AmazonEKS_CNI_Policy",
    "AmazonEC2ContainerRegistryReadOnly",
  ])
}

resource "aws_iam_role" "cluster_role" {
  name                 = var.cluster_role_name
  path                 = "/"
  max_session_duration = 3600

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = ["sts:AssumeRole", "sts:TagSession"]
      Effect    = "Allow"
      Principal = {
        Service = ["eks.amazonaws.com", "ec2.amazonaws.com"]
      }
    }]
  })

  tags = var.tags
}

resource "aws_iam_role" "node_role" {
  name                 = var.node_role_name
  path                 = "/"
  max_session_duration = 3600

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = var.tags
}

resource "aws_iam_role" "node_group_role" {
  name                 = var.node_group_role_name
  path                 = "/"
  max_session_duration = 3600

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "cluster_role" {
  for_each   = local.cluster_role_policies
  policy_arn = "${local.eks_policy_arn_prefix}/${each.value}"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_iam_role_policy_attachment" "node_role" {
  for_each   = local.node_role_policies
  policy_arn = "${local.eks_policy_arn_prefix}/${each.value}"
  role       = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "node_group_role" {
  for_each   = local.node_group_role_policies
  policy_arn = "${local.eks_policy_arn_prefix}/${each.value}"
  role       = aws_iam_role.node_group_role.name
}