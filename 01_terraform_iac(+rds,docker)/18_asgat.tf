resource "aws_autoscaling_attachment" "ogurim_asgat" {
    autoscaling_group_name = aws_autoscaling_group.ogurim_asg.id
    lb_target_group_arn = aws_lb_target_group.ogurim_albtg.arn
}