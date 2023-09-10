resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = merge ({
    Name = "${var.env}-vpc"
  },
    var.tags )
}

resource "aws_subnet" "main" {
  count = var.web_subnet
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.web_subnet, count.index )

  tags = merge ({
    Name = "${var.env}-subnet"
  },
    var.tags )
}




