### aws/02_vpc.tf ###

# VPC
resource "aws_vpc" "ogurim_vpc" {
  cidr_block           = var.ip_ranges[2]
  instance_tenancy     = "default"
  enable_dns_support   = var.boolean_list[1]
  enable_dns_hostnames = var.boolean_list[1]

  tags = {
    Name = "${var.name}-vpc"
  }
}


# 서브넷
resource "aws_subnet" "ogurim_subnet" {
  count = length(var.subnet_types)

  vpc_id                  = aws_vpc.ogurim_vpc.id
  cidr_block              = var.subnet_cidrs[count.index]
  availability_zone       = "${var.region}${substr(var.subnet_types[count.index], -1, 1)}"
  map_public_ip_on_launch = count.index == 0 || count.index == 1 ? true : false

  tags = {
    Name = "${var.name}-${var.subnet_types[count.index]}"
  }
}


# 디폴트 보안 그룹
resource "aws_security_group" "ogurim_sg" {
  name        = "${var.name}-sg"
  description = "default-ssh-icmp"
  vpc_id      = aws_vpc.ogurim_vpc.id

  dynamic "ingress" {
    for_each = var.security_group_default_rules
    content {
      description      = ingress.value[0]
      from_port        = ingress.value[1]
      to_port          = ingress.value[2]
      protocol         = ingress.value[3]
      cidr_blocks      = [ingress.value[4]]
      ipv6_cidr_blocks = [ingress.value[5]]
      security_groups  = null
      prefix_list_ids  = null
      self             = null
    }
  }

  egress = [
    {
      description      = "all"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["${var.ip_ranges[0]}"]
      ipv6_cidr_blocks = ["${var.ip_ranges[1]}"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    "Name" = "${var.name}-sg"
  }
}

# 웹 보안 그룹
resource "aws_security_group" "ogurim_web_sg" {
  name        = "${var.name}-web-sg"
  description = "default-ssh-icmp"
  vpc_id      = aws_vpc.ogurim_vpc.id

  dynamic "ingress" {
    for_each = var.security_group_web_rules
    content {
      description      = ingress.value[0]
      from_port        = ingress.value[1]
      to_port          = ingress.value[2]
      protocol         = ingress.value[3]
      cidr_blocks      = [ingress.value[4]]
      ipv6_cidr_blocks = [ingress.value[5]]
      security_groups  = ingress.value[0] == "all" ? null : [aws_security_group.ogurim_sg.id]
      prefix_list_ids  = null
      self             = null
    }
  }

  egress = [
    {
      description      = "all"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["${var.ip_ranges[0]}"]
      ipv6_cidr_blocks = ["${var.ip_ranges[1]}"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    "Name" = "${var.name}-web-sg"
  }
}

# DB 보안 그룹
resource "aws_security_group" "ogurim_db_sg" {
  name        = "${var.name}-db-sg"
  description = "default-ssh-icmp"
  vpc_id      = aws_vpc.ogurim_vpc.id

  dynamic "ingress" {
    for_each = var.security_group_db_rules
    content {
      description      = ingress.value[0]
      from_port        = ingress.value[1]
      to_port          = ingress.value[2]
      protocol         = ingress.value[3]
      cidr_blocks      = [ingress.value[4]]
      ipv6_cidr_blocks = [ingress.value[5]]
      security_groups  = [aws_security_group.ogurim_sg.id]
      prefix_list_ids  = null
      self             = null
    }
  }

  egress = [
    {
      description      = "all"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["${var.ip_ranges[0]}"]
      ipv6_cidr_blocks = ["${var.ip_ranges[1]}"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    "Name" = "${var.name}-db-sg"
  }
}






# 인터넷 게이트웨이
resource "aws_internet_gateway" "ogurim_ig" {
  vpc_id = aws_vpc.ogurim_vpc.id

  tags = {
    Name = "${var.name}-ig"
  }
}

# 라우팅 테이블
resource "aws_route_table" "ogurim_rt" {
  vpc_id = aws_vpc.ogurim_vpc.id

  route {
    cidr_block = var.ip_ranges[0]
    gateway_id = aws_internet_gateway.ogurim_ig.id
  }

  tags = {
    Name = "${var.name}-rt"
  }
}

resource "aws_route_table_association" "ogurim_rtas" {
  count          = 2
  subnet_id      = aws_subnet.ogurim_subnet[count.index].id
  route_table_id = aws_route_table.ogurim_rt.id
}

# NAT 라우팅 테이블
resource "aws_eip" "ogurim_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "ogurim_nig" {
  allocation_id = aws_eip.ogurim_eip.id
  subnet_id     = aws_subnet.ogurim_subnet[0].id
  private_ip    = var.private_ips[0]
  depends_on    = [aws_internet_gateway.ogurim_ig]

  tags = {
    Name = "${var.name}-nig"
  }
}

resource "aws_route_table" "ogurim_nrt" {
  vpc_id = aws_vpc.ogurim_vpc.id

  route {
    cidr_block = var.ip_ranges[0]
    gateway_id = aws_nat_gateway.ogurim_nig.id
  }

  tags = {
    Name = "${var.name}-nrt"
  }
}

resource "aws_route_table_association" "ogurim_nrtas_w" {
  count          = 2
  subnet_id      = aws_subnet.ogurim_subnet[count.index + 2].id
  route_table_id = aws_route_table.ogurim_nrt.id
}

resource "aws_route_table_association" "ogurim_nrtas_d" {
  count          = 2
  subnet_id      = aws_subnet.ogurim_subnet[count.index + 4].id
  route_table_id = aws_route_table.ogurim_nrt.id
}

