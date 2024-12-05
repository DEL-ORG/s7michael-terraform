

resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = var.instance_type

  key_name        = data.aws_key_pair.key_pair.key_name
  security_groups = [data.aws_security_group.sg.name]

  tags = {
    Name = "Bastion Host"
  }
}
