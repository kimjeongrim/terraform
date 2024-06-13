resource "aws_route_table_association" "ogurim_nrtas_a" {
  subnet_id      = aws_subnet.ogurim_sub_dca_1.id
  route_table_id = aws_route_table.ogurim_nrt.id
}

resource "aws_route_table_association" "ogurim_nrtas_c" {
  subnet_id      = aws_subnet.ogurim_sub_dcc_1.id
  route_table_id = aws_route_table.ogurim_nrt.id
}