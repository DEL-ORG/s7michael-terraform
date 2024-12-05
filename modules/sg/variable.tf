variable "aws_security_group" {
  type    = string
  default = ""
}

# variable "cidr_blocks" {
#   type = string
# }

variable "tags" {
  type = map(string)
}

variable "region" {
  type = string
}

variable "resource_name"{
  type = string
}