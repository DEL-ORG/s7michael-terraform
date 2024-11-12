# Define an AWS security group

data "aws_security_group" "existing_sg" {
  filter {
    name   = "group-name"
    values = ["allow_tls"]
  }
}

# Define an EC2 instance
resource "aws_instance" "my-console" {
  ami           = var.ami_id
  instance_type = var.instance_type           

  # Optional: Assign a key pair for SSH access
  key_name = var.key_name

  # Optional: Set the instance tags
  tags = {
    Name = "test-instance"
  }

  # Optional: Attach the security group to the EC2 instance
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id] 
  subnet_id = "subnet-0cbaf29bca2861e88"
}

