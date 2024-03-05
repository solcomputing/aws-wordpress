data "aws_iam_policy_document" "key_Access" {
  statement {
    actions = [
      "kms:CreateAlias",      
      "kms:CreateGrant",
      "kms:DeleteAlias",
      "kms:DisableKey",
      "kms:EnableKey",
      "kms:PutKeyPolicy",
      "kms:RevokeGrant",
      "kms:ScheduleKeyDeletion",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:UpdateAlias",
      "kms:UpdateKeyDescription"
    ]

    resources = [
      "arn:aws:kms:${var.eks_cluster_region}:${var.eks_policy_user}:key/*",
      "arn:aws:kms:${var.eks_cluster_region}:${var.eks_policy_user}:alias/*"
    ]
  }

  statement {
    actions = ["kms:CreateKey"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "policy" {
   name        = "terraform_${var.clustername}_key_Access_policy"
   description = "${var.clustername}_key_Access_policy"
   policy      = data.aws_iam_policy_document.key_Access.json
}

resource "aws_kms_key" "cluster" {
  count                   = var.cluster_encryption_config_enabled && var.cluster_encryption_config_kms_key_id == "" ? 1 : 0
  description             = "EKS Cluster ${var.clustername} Encryption Config KMS Key"
  enable_key_rotation     = var.cluster_encryption_config_kms_key_enable_key_rotation
  deletion_window_in_days = var.cluster_encryption_config_kms_key_deletion_window_in_days
  policy                  = aws_iam_policy.policy.id
  tags = {
    Name = join("-", ["aws_kms_key", var.clustername])
  }
}