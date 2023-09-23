resource "aws_vpc" "main" {
  cidr_block        = var.cidr_block

  tags              = merge ({
    Name            = "${var.env}-vpc"
  },
    var.tags )
}

module "subnets" {
  source = "./subnets"
  for_each = var.subnets
  cidr_block = each.value["cidr_block"]
  subnet_name = each.key
  vpc_id = aws_vpc.main.id
  az     = var.az

  env    = var.env
  tags   = var.tags
}

###Deafault VPC to Dev/Prod VPC Peering Connection.
resource "aws_vpc_peering_connection" "peer" {
  #peer_owner_id = var.peer_owner_id
  peer_vpc_id   = aws_vpc.main.id
  vpc_id        = var.default_vpc_id
  auto_accept   = true
}

##Internet gateway( one VPC one internet gateway)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags              = merge ({
    Name            = "${var.env}-igw"
  },
    var.tags )
}






