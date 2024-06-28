### aws/03_ec2.tf ###

# ami
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

# 인스턴스
resource "aws_instance" "ogurim_weba" {
  ami                    = data.aws_ami.amzn.id
  instance_type          = var.instance_types[0]
  key_name               = var.public_key[0]
  availability_zone      = "${var.region}a"
  private_ip             = var.private_ips[1]
  subnet_id              = aws_subnet.ogurim_subnet[0].id
  vpc_security_group_ids = [aws_security_group.ogurim_sg.id, aws_security_group.ogurim_web_sg.id]
  user_data              = file("${var.user_data[0]}")

  tags = {
    Name = "${var.name}-${var.subnet_types[0]}"
  }
}


resource "aws_instance" "ogurim_webc" {
  monitoring             = true
  ami                    = data.aws_ami.amzn.id
  instance_type          = var.instance_types[0]
  key_name               = var.public_key[0]
  availability_zone      = "${var.region}c"
  private_ip             = var.private_ips[2]
  subnet_id              = aws_subnet.ogurim_subnet[1].id
  vpc_security_group_ids = [aws_security_group.ogurim_sg.id, aws_security_group.ogurim_web_sg.id]
  user_data              = file("${var.user_data[2]}")

  tags = {
    Name = "${var.name}-${var.subnet_types[1]}"
  }
}


resource "aws_instance" "ogurim_wasa" {
  ami                    = data.aws_ami.amzn.id
  instance_type          = var.instance_types[0]
  key_name               = var.public_key[0]
  availability_zone      = "${var.region}a"
  private_ip             = var.private_ips[3]
  subnet_id              = aws_subnet.ogurim_subnet[2].id
  vpc_security_group_ids = [aws_security_group.ogurim_sg.id]

  depends_on = [aws_internet_gateway.ogurim_ig]

  tags = {
    Name = "${var.name}-${var.subnet_types[2]}"
  }
}

resource "aws_instance" "ogurim_wasc" {
  ami                    = data.aws_ami.amzn.id
  instance_type          = var.instance_types[0]
  key_name               = var.public_key[0]
  availability_zone      = "${var.region}c"
  private_ip             = var.private_ips[4]
  subnet_id              = aws_subnet.ogurim_subnet[3].id
  vpc_security_group_ids = [aws_security_group.ogurim_sg.id]

  depends_on = [aws_internet_gateway.ogurim_ig]

  tags = {
    Name = "${var.name}-${var.subnet_types[3]}"
  }
}

# EBS(볼륨, 스냅샷)
resource "aws_ebs_volume" "ogurim_ebs" {
  availability_zone = "${var.region}c"
  size              = 20

  tags = {
    Name = "${var.name}-ebs"
  }
}

resource "aws_volume_attachment" "ogurim_ebs_at_webc" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ogurim_ebs.id
  instance_id = aws_instance.ogurim_webc.id
}

resource "aws_ebs_snapshot" "ogurim_ebs_ss_webc" {
  volume_id = aws_ebs_volume.ogurim_ebs.id
  tags = {
    Name = "${var.name}-ebs-ss-webc"
  }
}


# 어플리케이션 로드밸런서
resource "aws_lb" "ogurim_lb" {
  name               = "${var.name}-lb"
  internal           = var.boolean_list[0]
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.ogurim_sg.id, aws_security_group.ogurim_web_sg.id]
  subnets            = [aws_subnet.ogurim_subnet[0].id, aws_subnet.ogurim_subnet[1].id]

  tags = {
    Name = "${var.name}-lb"
  }
}

resource "aws_lb_target_group" "ogurim_albtg" {
  name     = "${var.name}-albtg"
  protocol = "HTTP"
  port     = 80
  vpc_id   = aws_vpc.ogurim_vpc.id

  health_check {
    enabled           = true
    healthy_threshold = 2
    #default 3 (2~10)
    interval = 5
    #default 30 (5~300)
    matcher  = "200"
    path     = "/index.html"
    port     = "traffic-port"
    protocol = "HTTP"
    timeout  = 3
    # default 5 (2~120)
    unhealthy_threshold = 3
    # default 3 (2~10)
  }

  tags = {
    Name = "${var.name}-albtg"
  }

}

resource "aws_lb_listener" "ogurim_albli" {
  load_balancer_arn = aws_lb.ogurim_lb.arn
  #arn : aws resource name
  protocol = "HTTP"
  port     = "80"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ogurim_albtg.arn
  }

  tags = {
    Name = "${var.name}-albli"
  }
}

# 오토 스케일링
resource "aws_ami_from_instance" "ogurim_ami" {
  name               = "${var.name}-ami"
  source_instance_id = aws_instance.ogurim_weba.id

  depends_on = [aws_instance.ogurim_weba]

  tags = {
    Name = "${var.name}-ami"
  }
}

resource "aws_launch_template" "ogurim_lt" {
  name = "${var.name}-lt"

  block_device_mappings {

    device_name = "/dev/sdd"
    ebs {
      volume_size = 10
      volume_type = var.ssd_type
    }
  }

  image_id               = aws_ami_from_instance.ogurim_ami.id
  instance_type          = var.instance_types[0]
  key_name               = var.public_key[0]
  vpc_security_group_ids = [aws_security_group.ogurim_sg.id, aws_security_group.ogurim_web_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name}-lt"
    }
  }
}

resource "aws_autoscaling_group" "ogurim_asg" {
  name                      = "${var.name}-asg"
  min_size                  = 1
  max_size                  = 6
  desired_capacity          = 1
  health_check_grace_period = 30
  health_check_type         = "EC2"
  force_delete              = false
  vpc_zone_identifier       = [aws_subnet.ogurim_subnet[0].id]

  launch_template {
    id      = aws_launch_template.ogurim_lt.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "ogurim_asgat" {
  autoscaling_group_name = aws_autoscaling_group.ogurim_asg.id
  lb_target_group_arn    = aws_lb_target_group.ogurim_albtg.arn
}

