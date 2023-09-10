resource "aws_vpc" "main" {
  cidr_block        = var.cidr_block

  tags              = merge ({
    Name            = "${var.env}-vpc"
  },
    var.tags )
}

module "subnets" {
  source = "../subnets"
  for_each = var.subnets
  cidr_block = each.value["cidr_block"]
  subnet_name = each.key
  vpc_id = aws_vpc.main.id

  env    = var.env
  tags   = var.tags
}






