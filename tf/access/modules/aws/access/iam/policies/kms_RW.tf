data "aws_iam_policy_document" "keyAccess_RW" {
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

    resources = ["*"]
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

