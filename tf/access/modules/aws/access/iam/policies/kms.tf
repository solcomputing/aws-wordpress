data "aws_iam_policy_document" "keyAccess" {
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

resource "aws_iam_policy" "keyAccess" {
   name        = "aws-${var.entity}keyAccessPolicy"
   description = "aws-${var.entity}keyAccessPolicy"
   policy      = data.aws_iam_policy_document.keyAccess.json
}

