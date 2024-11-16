packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "source_ami" {
  type    = string
  default = "ami-0cde6390e61a03eee"
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

# Define the builder to create an AMI on AWS
source "amazon-ebs" "privatevm-ami" {
  region                      = "us-east-1"
  instance_type               = "t2.micro"
  source_ami                  = "ami-0866a3c8686eaeeba"
  ami_name                    = "ubuntu-ami-{{timestamp}}"
  ami_description             = "Ubuntu AMI Private.Vm01"
  ssh_username                = "ubuntu"
  associate_public_ip_address = true
#   key_pair_name               = "practice-jenkins"

  tags = {
    Name        = "Private.Vm AMI"
    Environment = "Dev"
  }
}

# Build Block to initiate the image creation
build {
  sources = [
    "source.amazon-ebs.privatevm-ami"
  ]
}
