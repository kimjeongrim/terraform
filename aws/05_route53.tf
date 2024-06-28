### aws/05_route53.tf ###

resource "aws_route53_zone" "ogurim_zone" {

  name = var.router53[0]

  tags = {
    Name = "ogurim-zone"
    # Environment = "${var.router53[1]}"
  }
}

# Alias Record
resource "aws_route53_record" "www" {

  name    = var.router53[2]
  type    = "A"
  zone_id = aws_route53_zone.ogurim_zone.zone_id

  alias {
    name = aws_lb.ogurim_lb.dns_name
    # name   = aws_s3_bucket.www_ogurim_store.website_endpoint
    zone_id                = aws_lb.ogurim_lb.zone_id
    evaluate_target_health = true
  }
}
# route 53 cname < alias : 상대적으로 빠른 응답시간과 무료
