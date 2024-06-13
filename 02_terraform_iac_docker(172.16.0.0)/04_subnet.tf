resource "aws_subnet" "ogurim_sub_dca" { #public
  vpc_id                  = aws_vpc.ogurim_vpc.id
  cidr_block              = "172.16.0.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "ogurim-sub-dca"
  }
}

resource "aws_subnet" "ogurim_sub_dcc" { #public
  vpc_id                  = aws_vpc.ogurim_vpc.id
  cidr_block              = "172.16.1.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "ogurim-sub-dcc"
  }
}


resource "aws_subnet" "ogurim_sub_dca_1" { #private
  vpc_id            = aws_vpc.ogurim_vpc.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "ogurim-sub-dca-1"
  }
}


resource "aws_subnet" "ogurim_sub_dcc_1" { #private
  vpc_id            = aws_vpc.ogurim_vpc.id
  cidr_block        = "172.16.3.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "ogurim-sub-dcc-1"
  }
}
