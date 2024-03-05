resource "aws_s3_bucket" "s3store" {
  bucket	= "${var.bucket_name}"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
}