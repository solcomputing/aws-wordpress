data "aws_iam_policy_document" "S3Bucket_RW" {
  statement {
    actions = [
        "s3:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "S3Bucket_RW" {
   name        = "aws-${var.entity}S3BucketPolicy-RW"
   description = "aws-${var.entity}S3BucketPolicy-RW"
   policy      = data.aws_iam_policy_document.S3Bucket_RW.json
}
