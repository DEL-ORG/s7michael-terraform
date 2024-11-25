data "aws_vpc" "selected_vpc" {
  filter {
    name   = "tag:name"
    values = ["default_vpc"]
  }
}

data "aws_ami" "ec2_ami" {
  most_recent = false

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20240927"]

  }
}

data "aws_subnet" "subnet-01" {
  filter {
    name   = "tag:Name"
    values = ["default_us-east1a"]
  }
}

data "aws_security_group" "ec2_sg" {
  filter {
    name   = "tag:Name"
    values = ["ec2_sg"]
  }
}




