resource "aws_lb_listener" "ogurim_albli" {
  load_balancer_arn = aws_lb.ogurim_lb.arn
  #arn : aws resource name
  port     = "80"
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ogurim_albtg.arn
  }

  tags = {
    Name = "ogurim-albli"
  }
}
