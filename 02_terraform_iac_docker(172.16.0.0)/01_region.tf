provider "aws" {
  # alias = "seoul"
  region = "ap-northeast-2"

}

resource "aws_key_pair" "ogurim" {
  key_name   = "ogurim"
  public_key = file(".ogurim.pub")
}


# 다중 정의시 ec2 인스턴스 생성 
/*
resource "aws_instance" "app_server" {
  provider = aws.seoul
  ami = "ami-034a31ed1d34ef024"
  instance_type = "t2.micro"
}
*/