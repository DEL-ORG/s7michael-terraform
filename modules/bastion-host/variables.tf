variable "region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The vpc id to use."
  type        = string
  default     = "vpc-05c24e3db705eb180"
}

# variable "ami_id" {
# description = "The ID of the Amazon Machine Image (AMI) to use for the EC2 instance."
# type        = string
# default     = "ami-0866a3c8686eaeeba"
# }
# 
variable "instance_type" {
  description = "The type of EC2 instance to create."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the SSH key pair to use for EC2 access."
  type        = string
}

variable "volume_size" {
  description = "The size of the volume for the ec2."
  type        = string
}

variable "volume_type" {
  description = "The type of the volume for the ec2."
  type        = string
}

variable "tags" {
  description = "The size of the volume for the ec2."
  type        = map(string)
}

variable "resource_name" {
  type = string
}

# variable "aws_ami" {
  # description = "AMI ID for the EC2 instance"
  # type        = string
# }
# 
# variable "aws_subnet" {
  # description = "Subnet ID for the EC2 instance"
  # type        = string
# }
# 
# variable "aws_security_group" {
  # description = "Security group IDs for the EC2 instance"
  # type        = list(string)
# }
