data "aws_iam_policy_document" "groupPolicy_RW" {
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

resource "aws_iam_policy" "groupPolicy_RW" {
   name        = "aws-${var.entity}GroupPolicy-RW"
   description = "aws-${var.entity}GroupPolicy-RW"
   policy      = data.aws_iam_policy_document.groupPolicy_RW.json
}

