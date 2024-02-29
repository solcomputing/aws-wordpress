
variable "vpc_azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["eu-west-1a"]
}

variable "vpc_name" {
default = "wordpress"
description = "VPC: Region/Zone/Name"
type = string
}

variable "vpc_public_subnet" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = []
}
 
variable "vpc_private_subnet" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = []
}
