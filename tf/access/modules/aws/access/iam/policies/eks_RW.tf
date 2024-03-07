data "aws_iam_policy_document" "eks_RW" {
  statement {
    actions = [
	  "EKS:CreateCluster",
      "EKS:DescribeCluster",
      "EKS:DeleteCluster",
      "EKS:ListFargateProfiles",
      "EKS:DescribeNodegroup",
      "EKS:ListNodegroups",
      "EKS:ListUpdates",
      "EKS:AccessKubernetesApi",
      "EKS:ListAddons",
      "EKS:DescribeCluster",
      "EKS:DescribeAddonVersions",
      "EKS:ListClusters",
      "EKS:ListIdentityProviderConfigs",
      "iam:ListRoles"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "eks_RW" {
   name        = "aws-${var.entity}eks-RW"
   description = "aws-${var.entity}eks-RW"
   policy      = data.aws_iam_policy_document.eks_RW.json
}
