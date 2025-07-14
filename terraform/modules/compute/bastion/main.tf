resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_ids[0]
  key_name = var.key_name

  vpc_security_group_ids = [ var.bastion_security_group_id ]

  tags = {
    Name = "${var.project}-bastion-${var.stage}"
  }
}