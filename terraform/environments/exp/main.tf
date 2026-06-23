
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# IAM Roles
module "iam_roles" {
  source = "../../modules/iam-roles"

  cluster_role_name    = "AmazonEKSAutoClusterRole-${var.env}"
  node_role_name       = "AmazonEKSAutoNodeRole-${var.env}"
  node_group_role_name = "AmazonEKSNodeRole-nodegroup-${var.env}"

  tags = var.tags
}

# Security Group
module "security_group" {
  source = "../../modules/security-groups"

  name         = "eks-cluster-sg-${var.cluster_name}"
  description  = "EKS created security group applied to ENI that is attached to EKS Control Plane master nodes"
  vpc_id       = var.vpc_id
  cluster_name = var.cluster_name


  tags = var.tags
}

# EKS Cluster
module "eks_cluster" {
  source = "../../modules/eks-cluster"

  cluster_name    = var.cluster_name
  region          = var.region
  cluster_version = var.cluster_version
  cluster_role_arn = module.iam_roles.cluster_role_arn

  subnet_ids              = var.subnet_ids
  service_ipv4_cidr       = var.service_ipv4_cidr
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  public_access_cidrs     = var.public_access_cidrs

  tags = var.tags

  depends_on = [module.iam_roles]
}

# CRITICAL: Deploy vpc-cni BEFORE node groups
module "eks_addons_pre_nodes" {
  source = "../../modules/eks-addons"

  cluster_name = module.eks_cluster.cluster_name
  eks_addons   = var.eks_addons_pre_node

  depends_on = [module.eks_cluster]
}

# EKS Node Groups
module "node_groups" {
  source = "../../modules/eks-node-group"

  for_each = var.node_groups

  cluster_name    = module.eks_cluster.cluster_name
  node_group_name = each.key
  node_role_arn   = module.iam_roles.node_group_role_arn
  subnet_ids      = var.subnet_ids

  instance_types  = each.value.instance_types
  ami_type        = each.value.ami_type
  capacity_type   = each.value.capacity_type
  disk_size       = each.value.disk_size
  desired_size    = each.value.desired_size
  max_size        = each.value.max_size
  min_size        = each.value.min_size
  release_version = each.value.release_version

  kubernetes_version = var.cluster_version

  tags = var.tags

  depends_on = [module.eks_cluster, module.iam_roles]
}

module "eks_addons_post_nodes" {
  source = "../../modules/eks-addons"

  cluster_name = module.eks_cluster.cluster_name
  eks_addons   = var.eks_addons_post_node

  depends_on = [module.node_groups]
}