resource "aws_eip" "ogurim_eip" {
  domain = "vpc"
}

output "eip" {
  value = aws_eip.ogurim_eip.public_ip
}

resource "aws_nat_gateway" "ogurim_nigw" {
  allocation_id = aws_eip.ogurim_eip.id
  subnet_id     = aws_subnet.ogurim_sub_dca.id
  private_ip    = "172.16.0.21"
  depends_on    = [aws_internet_gateway.ogurim_igw]

  tags = {
    Name = "ogurim-nigw"
  }
}
