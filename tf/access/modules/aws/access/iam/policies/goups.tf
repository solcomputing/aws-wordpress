data "aws_iam_policy_document" "groupPolicy" {
  statement {
    actions = [
		"iam:GetUser",
		"iam:UpdateUser",
		"iam:AddUserToGroup",
		"iam:GetGroup",
		"iam:RemoveUserFromGroup",
		"iam:RemoveUserFromGroup"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "groupPolicy" {
   name        = "aws-${var.entity}GroupPolicy"
   description = "aws-${var.entity}GroupPolicy"
   policy      = data.aws_iam_policy_document.groupPolicy.json
}

