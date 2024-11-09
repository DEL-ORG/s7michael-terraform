variable "region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "The ID of the Amazon Machine Image (AMI) to use for the EC2 instance."
  type        = string
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

# Define the security group name for the EC2 instance
variable "security_group_name" {
  description = "The name of the security group to apply to the EC2 instance."
  type        = string
  default     = "allow_ssh"
}
