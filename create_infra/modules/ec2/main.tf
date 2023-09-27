# create ec2 instance

resource "aws_instance" "public_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = var.public_ip
  subnet_id                   = var.subnet_ids
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_name
  tags                        = var.ec2_tag

}