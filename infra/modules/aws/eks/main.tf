data "aws_iam_policy" "policy" {
  name = "aws-${var.entity}keyAccessPolicy-RW"
}

resource "aws_kms_key" "cluster" {
  description             = "EKS Cluster ${var.clustername} Encryption Config KMS Key"
  enable_key_rotation     = var.cluster_encryption_config_kms_key_enable_key_rotation
  deletion_window_in_days = var.cluster_encryption_config_kms_key_deletion_window_in_days
  tags = {
    Name = join("-", ["aws_kms_key", var.clustername])
  }
}

data "aws_iam_role" "eks-iam-role" {
  name = "${var.entity}-eks-iam-role"
}

resource "aws_eks_cluster" "cluster" {
 name = "${var.clustername}-cluster"
 role_arn = data.aws_iam_role.eks-iam-role.arn

 vpc_config {
  subnet_ids = var.subnet_ids
 }
}

data "aws_iam_role" "workernodes" {
  name = "eks-${var.entity}-node-group-workernodes"
}

 resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = "${var.clustername}-cluster"
  node_group_name = "${var.clustername}-workernodes"
  node_role_arn   = data.aws_iam_role.workernodes.arn
  subnet_ids      = var.subnet_ids
  instance_types  = var.instance_types
 
  scaling_config {
   desired_size  = 1
   max_size      = 1
   min_size      = 1
  }
 }