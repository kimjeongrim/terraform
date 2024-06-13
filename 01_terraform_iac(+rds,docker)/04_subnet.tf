resource "aws_subnet" "ogurim_weba" {
  vpc_id            = aws_vpc.ogurim_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "ogurim-weba"
  }
}

resource "aws_subnet" "ogurim_webc" {
  vpc_id            = aws_vpc.ogurim_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "ogurim-webc"
  }
}


resource "aws_subnet" "ogurim_wasa" {
  vpc_id            = aws_vpc.ogurim_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-2a"
#  map_public_ip_on_launch = true

  tags = {
    Name = "ogurim-wasa"
  }
}


resource "aws_subnet" "ogurim_wasc" {
  vpc_id            = aws_vpc.ogurim_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-2c"
#   map_public_ip_on_launch = true

  tags = {
    Name = "ogurim-wasc"
  }
}


resource "aws_subnet" "ogurim_dba" {
  vpc_id            = aws_vpc.ogurim_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-northeast-2a"
#   map_public_ip_on_launch = true

  tags = {
    Name = "ogurim-dba"
  }
}


resource "aws_subnet" "ogurim_dbc" {
  vpc_id            = aws_vpc.ogurim_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "ap-northeast-2c"
#   map_public_ip_on_launch = true

  tags = {
    Name = "ogurim-dbc"
  }
}
