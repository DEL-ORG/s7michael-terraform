I have a data.tf file in my root module which has the parameters of some resources from my aws console. I have a main.tf file in my main module for the resource that i am trying to provision which also contains my "locals" and my "modules" which have the actual values of the resources to be provisioned. how will my data.tf under my root module be called or referenced in my main module?

this is my data.tf in my root module:
data "aws_vpc" "selected_vpc" {
  filter {
    name   = "tag:name"
    values = ["default_vpc"]
  }
}

data "aws_ami" "Ubuntu_ami" {
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


and this is my main.tf in my resource module:
# Configure the AWS provider
provider "aws" {
  region = local.region
}

locals {
  region        = "us-east-1"
  instance_type = "t2.micro"
  key_name      = "s77"
  volume_size   = "30"
  volume_type   = "gp3"
  tags = {
    owner       = "DEL"
    environment = "dev"
    project     = "alpha"
    created_by  = "Terraform"
  }
  resource_name = "alpha-ec2"
}

module "ec2" {
  source        = "../../../modules/ec2"
  region        = local.region
  instance_type = local.instance_type
  key_name      = local.key_name
  volume_size   = local.volume_size
  volume_type   = local.volume_type
  tags          = local.tags
  resource_name = "alpha-ec2"
}