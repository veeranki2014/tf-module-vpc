resource "aws_subnet" "main" {
  vpc_id     = var.vpc_id
  count      = length(var.cidr_block)
  cidr_block = element(var.cidr_block, count.index )
  availability_zone = element(var.az, count.index )

  tags = merge ({
    Name = "${var.env}-${var.subnet_name}-subnet"
  },
    var.tags )
}

##Route table one for each subnet
resource "aws_route_table" "table" {
  vpc_id = var.vpc_id

  tags = merge ({
    Name = "${var.env}-${var.subnet_name}"
  },
    var.tags )
}

resource "aws_route_table_association" "association" {
  count = length(aws_subnet.main.*.id)
  subnet_id      = element(aws_subnet.main.*.id, count.index )
  route_table_id = aws_route_table.table.id
}
