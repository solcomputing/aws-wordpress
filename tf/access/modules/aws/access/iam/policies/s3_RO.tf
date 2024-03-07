data "aws_iam_policy_document" "S3Bucket_RO" {
  statement {
    actions = [
      "S3:HeadBucket",
      "S3:ListBucket",
      "S3:GetBucketPolicy",
      "S3:GetBucketAcl",
      "S3:GetBucketCors",
      "S3:GetBucketVersioning",
      "S3:GetBucketAccelerateConfiguration"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "S3Bucket_RO" {
   name        = "aws-${var.entity}S3BucketPolicy-RO"
   description = "aws-${var.entity}S3BucketPolicy-RO"
   policy      = data.aws_iam_policy_document.S3Bucket_RO.json
}
