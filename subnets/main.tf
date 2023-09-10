resource "aws_subnet" "main" {
  vpc_id     = var.vpc_id
  count      = length(var.cidr_block)
  cidr_block = element(var.cidr_block, count.index )
  #availability_zone = element(var.az, count.index )

  tags = merge ({
    Name = "${var.env}-${var.subnet_name}-subnet"
  },
    var.tags )
}