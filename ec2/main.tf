# Define an AWS security group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22 # SSH port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define an EC2 instance
resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type           

  # Optional: Assign a key pair for SSH access
  key_name = var.key_name

  # Optional: Set the instance tags
  tags = {
    Name = "test-instance"
  }

  # Optional: Attach the security group to the EC2 instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}
