data "aws_iam_policy_document" "keyAccess_RO" {
  statement {
    actions = [
      "kms:ListAliases"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "keyAccess_RO" {
   name        = "aws-${var.entity}keyAccessPolicy-RO"
   description = "aws-${var.entity}keyAccessPolicy-RO"
   policy      = data.aws_iam_policy_document.keyAccess_RO.json
}

