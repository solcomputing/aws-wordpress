
locals {
  environments = {
    "default"       : local.development,
    "development"   : local.development,
    "production"    : local.production,
    "preprod"       : local.preprod
  }
}