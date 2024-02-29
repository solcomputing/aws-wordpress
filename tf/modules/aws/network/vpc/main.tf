
resource "aws_vpc" "main" {
 cidr_block = "10.0.0.0/16"
 
 tags = {
   Name = "${var.vpc_name}"
 }
}

resource "aws_subnet" "public_subnets" {
 count      = length(var.vpc_public_subnet)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.vpc_public_subnet, count.index)
 availability_zone = element(var.vpc_azs, count.index)

 tags = {
   Name = "az_${element(var.vpc_azs, count.index)}_public_subnet_${count.index + 1}"
 }
}

resource "aws_subnet" "private_subnets" {
 count      = length(var.vpc_private_subnet)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.vpc_private_subnet, count.index)
 availability_zone = element(var.vpc_azs, count.index)

 tags = {
   Name = "az_${element(var.vpc_azs, count.index)}_private_subnet_${count.index + 1}"
 }
}

resource "aws_internet_gateway" "gw" {
 vpc_id = aws_vpc.main.id
 tags = {
   Name = "${var.vpc_name}_INTERNET_GW"
 }
}