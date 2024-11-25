variable "ami_id" {
  description = "The AMI ID to use for the bastion host"
  type        = string
  default = "ami-0cde6390e61a03eee"
}

variable "instance_type" {
  description = "The instance type for the bastion host"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

# variable "public_key_path" {
#   description = "The path to the public key file for SSH access"
#   type        = string
# }
