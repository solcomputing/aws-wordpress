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

resource "aws_iam_role" "eks-iam-role" {
    name = "${var.clustername}-eks-iam-role"

 path = "/"

 assume_role_policy = <<EOF
{
 "Version" : "2012-10-17",
 "Statement" : [
  {
   "Effect" : "Allow",
   "Principal" : {
    "Service" : "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
 role    = aws_iam_role.eks-iam-role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 role    = aws_iam_role.eks-iam-role.name
}

resource "aws_eks_cluster" "cluster" {
 name = "${var.clustername}-cluster"
 role_arn = aws_iam_role.eks-iam-role.arn

 vpc_config {
  subnet_ids = var.subnet_ids
 }

 depends_on = [
  aws_iam_role.eks-iam-role,
 ]
}