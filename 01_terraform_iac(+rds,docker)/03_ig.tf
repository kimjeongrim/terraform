resource "aws_internet_gateway" "ogurim_ig" {
  vpc_id = aws_vpc.ogurim_vpc.id

  tags = {
    Name = "ogurim-ig"
  }
}
