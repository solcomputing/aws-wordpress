data "aws_iam_policy_document" "ecr_RO" {
  statement {
    actions = [
		"ecr:ListTagsForResource",
        "ecr:DescribeRepositories",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecr_RO" {
  name   = "aws-${var.entity}${var.group_name}EcrGroupPolicy-RO"
  path   = "/"
  policy = data.aws_iam_policy_document.ecr_RO.json
}