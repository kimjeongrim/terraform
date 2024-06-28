### aws/prod/seoul/03_outputs.tf ###

output "seoul_vpc_id" {
  value = module.seoul.vpc_id
}

output "seoul_nat_eip" {
  value = module.seoul.eip
}

output "seoul_ec2_public_ip_weba" {
  value = module.seoul.ec2_public_ip_weba
}

output "seoul_ec2_public_ip_webc" {
  value = module.seoul.ec2_public_ip_webc
}

output "seoul_ebs_volume_id" {
  value = module.seoul.ebs_volume_id
}

output "seoul_loadbalance_dns" {
  value = module.seoul.loadbalance_dns
}

output "seoul_db_ep" {
  value = module.seoul.ogurim_db_ep
}

output "seoul_www_record_dns_name" {
  value = module.seoul.www_record_dns_name
}

# output "seoul_s3_bucket_name" {
#   value = module.seoul.s3_bucket_name
# }

# output "seoul_s3_object_url" {
#   value = module.seoul.s3_object_url
# }

# output "seoul_s3_bucket_website_endpoint" {
#   value = module.seoul.s3_bucket_endpoint
# }
