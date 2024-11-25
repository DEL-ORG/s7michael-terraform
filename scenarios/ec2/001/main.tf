
resource "aws_instance" "my-console" {
  ami           = var.ami_id
  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]


  tags = {
    Name        = "Main_ec2"
    owner       = "DEL"
    environment = "dev"
    project     = "alpha"
    created_by  = "Terraform"
  }
}

