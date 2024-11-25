data "aws_security_group" "sg" {
  filter {
    name   = "group-name"
    values = ["bh_sg01"]
  }
}

data "aws_key_pair" "key_pair" {
  key_name = var.key_name
  # public_key = file(var.public_key_path)
}

resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = var.instance_type

  key_name        = data.aws_key_pair.key_pair.key_name
  security_groups = [data.aws_security_group.sg.name]

  tags = {
    Name = "Bastion Host"
  }
}
