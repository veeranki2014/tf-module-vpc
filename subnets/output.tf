### sending subnet_ids info to the other modules.
output "subnet_ids" {
  value = aws_subnet.main.*.id
}
##sending the route table info to other modules
output "route_table_ids" {
  value = aws_route_table.table.id
}

