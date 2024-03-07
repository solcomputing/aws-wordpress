data "aws_iam_policy_document" "operationonPolicy_RO" {
  statement {
    actions = [
		"iam:GetPolicy",
		"iam:ListPolicy",
        "iam:DescribePolicy",
        "iam:GetPolicyVersion"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "operationonPolicy_RO" {
   name        = "aws-${var.entity}operationonPolicy-RO"
   description = "aws-${var.entity}operationonPolicy-RO"
   policy      = data.aws_iam_policy_document.operationonPolicy_RO.json
}
