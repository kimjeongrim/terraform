data "aws_ami" "amzn" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10*-hvm-*-x86_64-gp2"]
    #   Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "ogurim_weba" {
  #ami = "ami-0d6e6a06d11d7777d"
  ami                    = data.aws_ami.amzn.id
  instance_type          = "t2.micro"
  key_name               = "ogurim"
  availability_zone      = "ap-northeast-2a"
  private_ip             = "10.0.0.11"
  subnet_id              = aws_subnet.ogurim_weba.id
  vpc_security_group_ids = [aws_security_group.ogurim_sg.id]
  user_data = file("user_data(web).sh")
 
  tags = {
    Name = "ogurim-weba"
  }
}
 
output "ec2_public_ip_weba" {
  value = aws_instance.ogurim_weba.public_ip
}

/*
resource "aws_instance" "ogurim_dba" {
  ami                    = data.aws_ami.amzn.id
  instance_type          = "t2.micro"
  key_name               = "ogurim"
  availability_zone      = "ap-northeast-2a"
  private_ip             = "10.0.4.11"
  subnet_id              = aws_subnet.ogurim_dba.id
  vpc_security_group_ids = [aws_security_group.ogurim_sg.id]
  user_data = file("user_data(db).sh")

  depends_on = [aws_route_table_association.ogurim_nrtas_da]
 
  tags = {
    Name = "ogurim-dba"
  }
}
*/