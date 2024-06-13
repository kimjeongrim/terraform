resource "aws_route_table_association" "ogurim_nrtas_wa" {
  subnet_id      = aws_subnet.ogurim_wasa.id
  route_table_id = aws_route_table.ogurim_nrt.id
}

resource "aws_route_table_association" "ogurim_nrtas_wc" {
  subnet_id      = aws_subnet.ogurim_wasc.id
  route_table_id = aws_route_table.ogurim_nrt.id
}

resource "aws_route_table_association" "ogurim_nrtas_da" {
  subnet_id      = aws_subnet.ogurim_dba.id
  route_table_id = aws_route_table.ogurim_nrt.id
}

resource "aws_route_table_association" "ogurim_nrtas_dc" {
  subnet_id      = aws_subnet.ogurim_dbc.id
  route_table_id = aws_route_table.ogurim_nrt.id
}
