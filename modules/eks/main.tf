resource "aws_eks_cluster" "main" {
  name     = "eks-cluster"
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_public_access  = true
    endpoint_private_access = true
  }
}

resource "aws_eks_node_group" "node1" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "node-group-1"
  node_role_arn   = var.cluster_role_arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}