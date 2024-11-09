# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Specify your AWS region
}

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
  ami           = "ami-0866a3c8686eaeeba" # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"              # Define the EC2 instance type

  # Optional: Assign a key pair for SSH access
  key_name = "s77" # Replace with your SSH key name

  # Optional: Set the instance tags
  tags = {
    Name = "test-instance"
  }

  # Optional: Attach the security group to the EC2 instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}
