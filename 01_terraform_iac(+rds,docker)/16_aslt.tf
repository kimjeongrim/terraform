resource "aws_launch_template" "ogurim_lt" {
  name = "ogurim-lt"
  block_device_mappings {

    device_name = "/dev/sdd"
    ebs {
      volume_size = 10
      volume_type = "gp2"
    }
  }

  image_id               = aws_ami_from_instance.ogurim_ami.id
  instance_type          = "t2.micro"
  key_name               = "ogurim"
  vpc_security_group_ids = [aws_security_group.ogurim_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ogurim-lt"
    }
  }
}

