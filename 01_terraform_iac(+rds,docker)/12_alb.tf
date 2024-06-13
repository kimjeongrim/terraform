resource "aws_lb" "ogurim_lb" {
    name = "ogurim-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.ogurim_sg.id]
    subnets = [aws_subnet.ogurim_weba.id, aws_subnet.ogurim_webc.id ]

    tags = {
        Name = "ogurim-lb"
    }
}

output "load_dns" {
    value = aws_lb.ogurim_lb.dns_name
}