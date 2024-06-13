resource "aws_security_group" "ogurim_sg" {
  name        = "ogurim-sg"
  description = "default-ssh-icmp"
  vpc_id      = aws_vpc.ogurim_vpc.id

  ingress = [
    {
      description      = "ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = "icmp"
      from_port        = -1
      to_port          = -1
      protocol         = "icmp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      description      = "all"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    "Name" = "ogurim-sg"
  }
}

resource "aws_security_group" "ogurim_websg" {
  name        = "ogurim-websg"
  description = "http-docker"
  vpc_id      = aws_vpc.ogurim_vpc.id

  ingress = [
    {
      description      = "all"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = [aws_security_group.ogurim_sg.id]
      self             = null
    },
    {
      description      = "http(docker)"
      from_port        = 61080
      to_port          = 61080
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
    /*
    ,{
      description      = "docker"
      from_port        = 60080
      to_port          = 65500
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
    */
  ]

  egress = [
    {
      description      = "all"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    "Name" = "ogurim-websg"
  }
}


resource "aws_security_group" "ogurim_dbsg" {
  name        = "ogurim-dbsg"
  description = "mysql"
  vpc_id      = aws_vpc.ogurim_vpc.id

  ingress = [
    {
      description      = "all"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = [aws_security_group.ogurim_sg.id]
      self             = null
    },
    {
      description      = "mysql"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = null
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = [aws_security_group.ogurim_sg.id]
      self             = null
    }
  ]

  egress = [
    {
      description      = "all"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    "Name" = "ogurim-dbsg"
  }
}
