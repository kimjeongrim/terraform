### aws/prod/tokyo/03_outputs.tf ###

output "tokyo_vpc_id" {
  value = module.tokyo.vpc_id
}

output "tokyo_ogurim_eip" {
  value = module.tokyo.eip
}

output "tokyo_ec2_public_ip_weba" {
  value = module.tokyo.ec2_public_ip_weba
}

output "tokyo_ec2_public_ip_webc" {
  value = module.tokyo.ec2_public_ip_webc
}

output "tokyo_ebs_volume_id" {
  value = module.tokyo.ebs_volume_id
}

output "tokyo_loadbalance_dns" {
  value = module.tokyo.loadbalance_dns
}

output "tokyo__db_ep" {
  value = module.tokyo.ogurim_db_ep
}

output "tokyo_www_record_dns_name" {
  value = module.tokyo.www_record_dns_name
}

# output "tokyo_s3_bucket_name" {
#   value = module.tokyo.s3_bucket_name
# }

# output "tokyo_s3_object_url" {
#   value = module.tokyo.s3_object_url
# }

# output "tokyo_s3_bucket_website_endpoint" {
#   value = module.tokyo.s3_bucket_endpoint
# }
