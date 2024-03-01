resource "aws_vpc" "main" {
 cidr_block = var.vpc_cidr_block
 
 tags = {
   Name = "${var.vpc_name}_${terraform.workspace}"
 }
}

resource "aws_subnet" "vpc_public_subnet" {
 count      = length(var.vpc_public_subnet)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.vpc_public_subnet, count.index)
 availability_zone = element(var.vpc_azs, count.index)
 map_public_ip_on_launch = "true"

 tags = {
   Name = "az_${element(var.vpc_azs, count.index)}_public_subnet_${count.index + 1}"
 }
}

resource "aws_subnet" "vpc_app_subnet" {
 count      = length(var.vpc_app_subnet)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.vpc_app_subnet, count.index)
 availability_zone = element(var.vpc_azs, count.index)
 map_public_ip_on_launch = "true"

 tags = {
   Name = "az_${element(var.vpc_azs, count.index)}_app_subnet_${count.index + 1}"
 }
}

resource "aws_subnet" "vpc_db_subnet" {
 count      = length(var.vpc_db_subnet)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.vpc_db_subnet, count.index)
 availability_zone = element(var.vpc_azs, count.index)
 map_public_ip_on_launch = "true"

 tags = {
   Name = "az_${element(var.vpc_azs, count.index)}_db_subnet_${count.index + 1}"
 }
}

resource "aws_internet_gateway" "igw" {
 vpc_id = aws_vpc.main.id
 depends_on = [
    aws_vpc.main,
    aws_subnet.vpc_public_subnet
  ]

 tags = {
   Name = "${var.vpc_name}_INTERNET_GW"
 }
}

resource "aws_route_table" "public_subnet" {
  count  = length(var.vpc_azs)
  vpc_id = aws_vpc.main.id
  tags = {
       Name = join("-", ["public_subnet_az${count.index + 1}", split("-", element(var.vpc_azs, count.index))[2]]) 
  }
}

resource "aws_eip" "nat" {
   count  = length(var.vpc_public_subnet)
   domain = "vpc"
}

resource "aws_nat_gateway" "NGW" {
  count         = length(var.vpc_public_subnet)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.vpc_public_subnet[count.index].id

  tags = {
    Name = join("-", [split("-", element(var.vpc_azs, count.index))[2], "NAT_GW_${aws_subnet.vpc_public_subnet[count.index].cidr_block}"])
  }
}

resource "aws_route" "private_nat_gateway" {
  count                  = length(var.vpc_public_subnet)
  route_table_id         = element(aws_route_table.public_subnet.*.id, count.index)
  nat_gateway_id         = element(aws_nat_gateway.NGW.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  depends_on = [
    aws_route_table.public_subnet,
    aws_nat_gateway.NGW,
  ]
}

resource "aws_route_table_association" "public_route_table" {
  count = length(var.vpc_public_subnet)
  subnet_id  = aws_subnet.vpc_public_subnet[count.index].id
  route_table_id = aws_route_table.public_subnet[count.index].id
  
  depends_on = [
    aws_subnet.vpc_public_subnet,
    aws_route_table.public_subnet
  ]
}