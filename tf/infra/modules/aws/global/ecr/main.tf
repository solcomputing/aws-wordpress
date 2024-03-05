resource "aws_ecr_repository" "registry" {
  for_each             = toset(var.repos)
  name                 = "${var.organization}_dockerhub_${each.value}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push       = true
  }
}