data "aws_iam_policy" "policy" {
  name = "aws-${var.entity}keyAccessPolicy-RW"
}

data "aws_iam_role" "eks-iam-role" {
  name = "${var.entity}-eks-iam-role"
}

resource "aws_eks_cluster" "cluster" {
 name = "${var.cluster_name}-cluster"
 role_arn = data.aws_iam_role.eks-iam-role.arn

 vpc_config {
  subnet_ids = concat(var.subnet_private_ids, var.subnet_public_ids)
 }
}

data "aws_iam_role" "workernodes" {
  name = "eks-${var.entity}-node-group-workernodes"
}

 resource "aws_eks_node_group" "worker-node-group-private" {
  cluster_name    = "${var.cluster_name}-cluster"
  node_group_name = "${var.cluster_name}-private-workernodes"
  node_role_arn   = data.aws_iam_role.workernodes.arn
  subnet_ids      = var.subnet_private_ids
  instance_types  = var.instance_types
 
  scaling_config {
   desired_size    = 1
   max_size        = 100
   min_size        = 1
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    node = "kubenode"
  }

  depends_on = [
    aws_eks_cluster.cluster
  ]
 }

 data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.cluster.name
}

provider "helm" {
  debug      = true
  alias      = "myhelm"

  kubernetes {
    host  = aws_eks_cluster.cluster.endpoint
    token = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}

data "vault_generic_secret" "aws_auth" {
  path = "secret/aws/gitlab"
}

 resource "helm_release" "gitlab_agent" {
  name             = "gitlab-agent"
  provider         = helm.myhelm
  repository       = "https://charts.gitlab.io"
  chart            = "gitlab-agent"
  create_namespace = true
  namespace        = var.cicd_agent_namespace

  set {
    name  = "config.kasAddress"
    value = data.vault_generic_secret.aws_auth.data["K8S_GITLAB_KASADDR"]
  }

  set {
    name  = "config.token"
    value = data.vault_generic_secret.aws_auth.data["K8S_GITLAB_TOKEN"]
  }
 }