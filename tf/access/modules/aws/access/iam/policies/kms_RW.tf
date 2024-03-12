data "aws_iam_policy_document" "keyAccess_RW" {
  statement {
    actions = [
      "kms:DisableKey",
      "kms:RevokeGrant",
      "kms:ScheduleKeyDeletion",
      "kms:Tag*",
      "kms:UntagResource",
      "kms:EnableKeyRotation",
      "kms:DescribeKey",
      "kms:Create*",
      "kms:CreateKey",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion"
    ]
    resources = var.arnaccount
  }
  statement {
    actions = ["kms:CreateKey"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "keyAccess_RW" {
   name        = "aws-${var.entity}keyAccessPolicy-RW"
   description = "aws-${var.entity}keyAccessPolicy-RW"
   policy      = data.aws_iam_policy_document.keyAccess_RW.json
}

