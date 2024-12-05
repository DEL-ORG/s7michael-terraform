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
  resource_name = local.resource_name
}

