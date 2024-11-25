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

variable "ami_id" {
  description = "The ID of the Amazon Machine Image (AMI) to use for the EC2 instance."
  type        = string
  default     = "ami-0866a3c8686eaeeba"
}

variable "instance_type" {
  description = "The type of EC2 instance to create."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the SSH key pair to use for EC2 access."
  type        = string
}

variable "aws_security_group" {
  description = "The name of the security group to apply to the EC2 instance."
  type        = string
  default     = "ec2_sg"
}
