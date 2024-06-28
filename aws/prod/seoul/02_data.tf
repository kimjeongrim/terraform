### aws/prod/seoul/02_data.tf ###

module "seoul" {
  source          = "../../"
  providers       = { aws = aws.seoul }
  region          = "ap-northeast-2"
  
  public_key      = ["ogurim", "../../.ogurim.pub"]
  peer_vpc_region = "ap-northeast-1"
  peer_vpc_cidr   = "192.168.0.0/16"

  name            = "seoul"
  ip_ranges       = ["0.0.0.0/0", "::/0", "10.0.0.0/16"]
  boolean_list    = [false, true]

  subnet_types = ["weba", "webc", "wasa", "wasc", "dba", "dbc"]
  subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  private_ips  = ["10.0.0.21", "10.0.0.11", "10.0.1.11", "10.0.2.11", "10.0.3.11", "10.0.4.11", "10.0.5.11"]
  user_data    = ["./resources/user_data(web).sh", "./resources/user_data(db).sh", "./resources/user_data(docker).sh"]

  instance_types = ["t2.micro", "db.t3.micro"]
  ssd_type       = "gp2"
  lb_type        = "application"

  security_group_default_rules = [
    ["ssh", 22, 22, "tcp", "0.0.0.0/0", "::/0"],
    ["icmp", -1, -1, "icmp", "0.0.0.0/0", "::/0"]
  ]
  security_group_web_rules = [
    ["all", 0, 0, -1, "0.0.0.0/0", "::/0"],
    ["http", 80, 80, "tcp", "0.0.0.0/0", "::/0"],
    ["docker", 60080, 60080, "tcp", "0.0.0.0/0", "::/0"]
  ]
  security_group_db_rules = [
    ["all", 0, 0, -1, "0.0.0.0/0", "::/0"],
    ["mysql", 3306, 3306, "tcp", "0.0.0.0/0", "::/0"]
  ]

  rds   = ["mysql", "5.7", "db.t3.micro", "wordpress", "ogurim-db"]
  mysql = ["root", "It12345!"]

  router53 = ["ogurim.store", "www", "www.ogurim.store", "A"]
  bucket   = ["www.ogurim.store"]
  s3       = ["1.png", "index.html", "error.html", "styles.css"]
  s3_path  = "./resources/"

  # peer_vpc_id     = module.tokyo.aws_vpc.vpc_id
  # peer_vpc_id     = "vpc-0ed70fbc92d27f502"
  # vpc_id = "vpc-02dd6eb256475851f"
}
