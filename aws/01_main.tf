### aws/01_main.tf ###

# 프로바이더
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

# 키 페어 
resource "aws_key_pair" "public_key" {
  key_name   = var.public_key[0]
  public_key = file("${var.public_key[1]}")
}
