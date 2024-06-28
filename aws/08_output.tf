### aws/08_outputs.tf ###

output "vpc_id" {
  value = aws_vpc.ogurim_vpc.id
}

output "eip" {
  value = aws_eip.ogurim_eip.public_ip
}

output "ec2_public_ip_weba" {
  value = aws_instance.ogurim_weba.public_ip
}

output "ec2_public_ip_webc" {
  value = aws_instance.ogurim_webc.public_ip
}

output "ebs_volume_id" {
  value = aws_ebs_volume.ogurim_ebs.id
}

output "loadbalance_dns" {
  value = aws_lb.ogurim_lb.dns_name
}

output "ogurim_db_ep" {
  value = aws_db_instance.ogurim_db.endpoint
}

output "www_record_dns_name" {
  value = aws_route53_record.www.fqdn
}

# output "s3_bucket_name" {
#   value = aws_s3_bucket.www_bk.bucket
# }

# output "s3_object_url" {
#   value = "http://${aws_s3_bucket.www_bk.bucket}.s3-website.${var.region}.amazonaws.com/1.png"
# }

# output "s3_bucket_endpoint" {
#   value = aws_s3_bucket.www_bk.bucket_regional_domain_name
# }
