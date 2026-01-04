provider "aws" {
  region = "us-east-1"
}

############################
# USE EXISTING LAB ROLE
############################

data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

############################
# NETWORK (Use Default VPC)
############################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

############################
# EKS CLUSTER
############################

resource "aws_eks_cluster" "eks" {
  name     = "lab-eks"
  role_arn = data.aws_iam_role.lab_role.arn

  vpc_config {
    subnet_ids = data.aws_subnets.default.ids
  }
}

############################
# NODE GROUP
############################

resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "lab-nodes"
  node_role_arn   = data.aws_iam_role.lab_role.arn
  subnet_ids      = data.aws_subnets.default.ids
  instance_types  = ["t3.medium"]
  disk_size       = 20

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }
}
