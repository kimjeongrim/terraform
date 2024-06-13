resource "aws_ami_from_instance" "ogurim_ami" {
  name               = "ogurim-ami"
  source_instance_id = aws_instance.ogurim_weba.id

  tags = {
    Name = "ogurim-ami"
  }
}
