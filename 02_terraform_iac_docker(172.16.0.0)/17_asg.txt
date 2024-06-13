resource "aws_autoscaling_group" "ogurim_asg" {
  name= "ogurim-asg"
  min_size = 1
  max_size = 6
  desired_capacity = 1
  health_check_grace_period = 30
  health_check_type = "EC2"
  force_delete = false
  vpc_zone_identifier = [aws_subnet.ogurim_weba.id, aws_subnet.ogurim_webc.id]

  launch_template {
    id = aws_launch_template.ogurim_lt.id
    version = "$Latest"
  }
}