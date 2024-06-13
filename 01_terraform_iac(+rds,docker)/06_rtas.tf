resource "aws_route_table_association" "ogurim_rtasa" {
    subnet_id = aws_subnet.ogurim_weba.id
    route_table_id = aws_route_table.ogurim_rt.id
}

resource "aws_route_table_association" "ogurim_rtasc" {
    subnet_id = aws_subnet.ogurim_webc.id
    route_table_id = aws_route_table.ogurim_rt.id
}