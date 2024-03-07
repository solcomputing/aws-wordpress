data "aws_iam_policy_document" "vpcPolicy_RW" {
  statement {
    actions = [
                "ec2:CreateVpc",
				"ec2:CreateTags",
				"ec2:DescribeVpcs",
				"ec2:DescribeVpcAttribute",
				"ec2:DeleteVpc",
				"ec2:CreateRouteTable",
				"ec2:DescribeRouteTables",
				"ec2:CreateSubnet",
				"ec2:DescribeSubnets",
				"ec2:DescribeNetworkInterfaces",
				"ec2:DeleteSubnet",
				"ec2:ModifySubnetAttribute",
				"ec2:CreateNatGateway",
				"ec2:DescribeNatGateways",
				"ec2:CreateInternetGateway",
				"ec2:AttachInternetGateway",
				"ec2:DescribeInternetGateways",
				"ec2:DeleteRouteTable",
				"ec2:AssociateRouteTable",
				"ec2:DeleteNatGateway",
				"ec2:DeleteInternetGateway",
				"ec2:CreateRoute",
				"ec2:DisassociateRouteTable",
				"ec2:DeleteRoute",
				"ec2:DisassociateAddress",
				"ec2:DetachInternetGateway",
				"ec2:AllocateAddress",
				"ec2:ReleaseAddress"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "vpcPolicy_RW" {
  name   = "aws-${var.entity}${var.group_name}VPCGroupPolicy-RW"
  path   = "/"
  policy = data.aws_iam_policy_document.vpcPolicy_RW.json
}