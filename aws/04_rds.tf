### aws/04_rds.tf ###

resource "aws_db_instance" "ogurim_db" {

  allocated_storage      = 20
  storage_type           = var.ssd_type
  engine                 = var.rds[0]
  engine_version         = var.rds[1]
  instance_class         = var.rds[2]
  db_name                = var.rds[3]
  identifier             = var.rds[4]
  username               = var.mysql[0]
  password               = var.mysql[1]
  availability_zone      = "${var.region}a"
  db_subnet_group_name   = aws_db_subnet_group.ogurim_dbsg.id
  vpc_security_group_ids = [aws_security_group.ogurim_sg.id, aws_security_group.ogurim_db_sg.id]
  skip_final_snapshot    = var.boolean_list[1]
  # replicate_source_db = aws_db_instance.ogurim_db.id
  tags = {
    Name = "${var.name}-db"
  }
}

resource "aws_db_subnet_group" "ogurim_dbsg" {
  name       = "${var.name}-dbsg"
  subnet_ids = [aws_subnet.ogurim_subnet[4].id, aws_subnet.ogurim_subnet[5].id]

  tags = {
    Name = "${var.name}-dbsg"
  }
}
