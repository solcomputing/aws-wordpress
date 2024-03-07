data "aws_iam_policy_document" "operationonPolicy_RW" {
  statement {
    actions = [
		"iam:CreateRole",
    "iam:GetRole",
    "iam:ListRolePolicies",
    "iam:ListAttachedRolePolicies",
    "iam:ListInstanceProfilesForRole",
    "iam:DeleteRole",
    "iam:AttachRolePolicy",
    "iam:UpdateAssumeRolePolicy",
    "iam:PassRole",
    "iam:DetachRolePolicy"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "operationonPolicy_RW" {
   name        = "aws-${var.entity}operationonPolicy-RW"
   description = "aws-${var.entity}operationonPolicy-RW"
   policy      = data.aws_iam_policy_document.operationonPolicy_RW.json
}
