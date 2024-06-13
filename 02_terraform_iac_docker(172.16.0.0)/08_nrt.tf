resource "aws_route_table" "ogurim_nrt" {
  vpc_id = aws_vpc.ogurim_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ogurim_nigw.id
  }

  tags = {
    Name = "ogurim-nrt"
  }
}
