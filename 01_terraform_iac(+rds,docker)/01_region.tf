provider "aws" {
    region = "ap-northeast-2"
    
}

resource "aws_key_pair" "ogurim" {
  key_name = "ogurim1"
  public_key = file("./.ogurim.pub")
}