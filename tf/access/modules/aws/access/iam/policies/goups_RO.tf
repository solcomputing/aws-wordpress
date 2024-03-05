data "aws_iam_policy_document" "groupPolicy_RO" {
  statement {
    actions = [
		"iam:GetUser",
		"iam:GetGroup",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "groupPolicy_RO" {
   name        = "aws-${var.entity}GroupPolicy-RO"
   description = "aws-${var.entity}GroupPolicy-RO"
   policy      = data.aws_iam_policy_document.groupPolicy_RO.json
}

