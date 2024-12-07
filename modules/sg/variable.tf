variable "aws_security_group" {
  type    = string
}

variable "ingress_ports" {
  type    = list(number)
}

variable "tags" {
  type = map(string)
}

variable "region" {
  type = string
}

variable "resource_name"{
  type = string
}