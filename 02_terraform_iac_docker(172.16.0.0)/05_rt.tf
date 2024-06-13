resource "aws_route_table" "ogurim_rt" {
  vpc_id = aws_vpc.ogurim_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ogurim_igw.id
  }

  tags = {
    Name = "ogurim-rt"
  }
}
