data "aws_vpc" "selected_vpc" {
  filter {
    name   = "tag:name"
    values = ["default_vpc"]
  }
}

data "aws_ami" "ubuntu_ami" {
  most_recent = false

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20240927"]

  }
}

data "aws_ami" "amazon_ami" {
  most_recent = false

  filter {
    name   = "name"
    values = ["al2023-ami-2023.6.20241121.0-kernel-6.1-x86_64"]

  }
}

data "aws_subnet" "subnet-01" {
  filter {
    name   = "tag:Name"
    values = ["default_us-east1a"]
  }
}

data "aws_security_group" "sg" {
  filter {
    name   = "tag:Name"
    values = ["dev-alpha-sg"]
  }
}

data "aws_key_pair" "key_pair" {
  # key_name           = "test"
  # include_public_key = true
  filter {
    name   = "tag:Name"
    values = ["s77"]
  }
}



