### aws/07_variables.tf ###

variable "region" {
  type = string
}

variable "public_key" {
  type = list(string)
}

variable "peer_vpc_region" {
  type = string
}

variable "peer_vpc_cidr" {
  type = string
}

variable "name" {
  type = string
}

variable "ip_ranges" {
  type = list(string)
}

variable "boolean_list" {
  type = list(bool)
}

variable "subnet_types" {
  type = list(string)
}

variable "subnet_cidrs" {
  type = list(string)
}

variable "private_ips" {
  type = list(string)
}

variable "user_data" {
  type = list(string)
}

variable "instance_types" {
  type = list(string)
}

variable "ssd_type" {
  type = string
}

variable "lb_type" {
  type = string
}

variable "security_group_default_rules" {
  type = list(list(any))
}

variable "security_group_web_rules" {
  type = list(list(any))
}

variable "security_group_db_rules" {
  type = list(list(any))
}

variable "rds" {
  type = list(string)
}

variable "mysql" {
  type = list(string)
}

variable "router53" {
  type = list(string)
}

variable "bucket" {
  type = list(string)
}

variable "s3" {
  type = list(string)
}

variable "s3_path" {
  type = string
}

# variable "peer_vpc_id" {
#   type = string
# }

# variable "vpc_id" {
#   type = string
# }