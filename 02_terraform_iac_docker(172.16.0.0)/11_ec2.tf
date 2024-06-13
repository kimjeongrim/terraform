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

resource "aws_instance" "ogurim_ins1" {
  monitoring = true
  ami                    = data.aws_ami.amzn.id
  instance_type          = "t2.micro"
  key_name               = "ogurim"
  availability_zone      = "ap-northeast-2a"
  private_ip             = "172.16.0.11"
  subnet_id              = aws_subnet.ogurim_sub_dca.id
  vpc_security_group_ids = [aws_security_group.ogurim_sg.id, aws_security_group.ogurim_websg.id, aws_security_group.ogurim_dbsg.id]
  user_data              = file("user_data(docker).sh")
  #depends_on             = [aws_internet_gateway.ogurim_igw]

  tags = {
    Name = "ogurim-ins1"
  }
}

output "ec2_public_ip_ins1" {
  value = aws_instance.ogurim_ins1.public_ip
}
