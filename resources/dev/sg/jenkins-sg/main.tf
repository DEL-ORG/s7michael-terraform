# Configure the AWS provider
provider "aws" {
  region = local.region
}

locals {
  aws_security_group = "ec2.sg"
  ingress_ports      = [80, 22, 443, 8080]

  tags = {
    owner       = "DEL"
    environment = "dev"
    project     = "alpha"
    created_by  = "Terraform"
  }

  region        = "us-east-1"
  resource_name = "jenkins-sg"
}

module "jenkins-sg" {
  source             = "../../../../modules/sg"
  aws_security_group = local.aws_security_group
  ingress_ports      = local.ingress_ports
  tags               = local.tags
  region             = local.region
  resource_name      = local.resource_name
}

