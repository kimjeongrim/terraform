resource "aws_db_instance" "ogurim_db" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  db_name                = "wordpress"
  identifier             = "ogurim-db"
  username               = "root"
  password               = "12345"
  availability_zone      = "ap-northeast-2a"
  db_subnet_group_name   = aws_db_subnet_group.ogurim_dbsg.id
  vpc_security_group_ids = [aws_security_group.ogurim_sg.id]
  skip_final_snapshot    = true

  tags = {
    Name = "ogurim-db"
  }
}

resource "aws_db_subnet_group" "ogurim_dbsg" {
  name       = "ogurim-dbsg"
  subnet_ids = [aws_subnet.ogurim_dba.id, aws_subnet.ogurim_dbc.id]

}

output "ogurim_db" {
  value = aws_db_instance.ogurim_db.endpoint
}