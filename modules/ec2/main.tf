
resource "aws_instance" "ec2_instance" {
  ami         = data.aws_ami.ubuntu_ami.id
  instance_type = var.instance_type

  key_name = data.aws_key_pair.key_pair.id

  subnet_id              = data.aws_subnet.subnet-01.id
  vpc_security_group_ids = [data.aws_security_group.sg.id]

  root_block_device {
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    delete_on_termination = true
  }

  tags = merge(var.tags, {
  Name = format("%s-%s-%s", var.tags["environment"], var.tags["project"], var.resource_name)
  })
}




