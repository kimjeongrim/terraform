resource "aws_route_table_association" "ogurim_rtas_a" {
  subnet_id      = aws_subnet.ogurim_sub_dca.id
  route_table_id = aws_route_table.ogurim_rt.id
}

resource "aws_route_table_association" "ogurim_rtas_c" {
  subnet_id      = aws_subnet.ogurim_sub_dcc.id
  route_table_id = aws_route_table.ogurim_rt.id
}
