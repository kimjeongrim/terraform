resource "aws_eip" "ogurim_eip" {
  domain = "vpc"
}

output "eip" {
  value = aws_eip.ogurim_eip.public_ip
}

resource "aws_nat_gateway" "ogurim_nig" {
  allocation_id = aws_eip.ogurim_eip.id
  subnet_id     = aws_subnet.ogurim_weba.id
  private_ip = "10.0.0.21"
  depends_on = [aws_internet_gateway.ogurim_ig]

  tags = {
    Name = "ogurim-nig"
  }
}
