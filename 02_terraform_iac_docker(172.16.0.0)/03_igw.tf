resource "aws_internet_gateway" "ogurim_igw" {
  vpc_id = aws_vpc.ogurim_vpc.id

  tags = {
    Name = "ogurim-ig"
  }
}
