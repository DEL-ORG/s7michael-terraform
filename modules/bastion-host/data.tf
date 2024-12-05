data "aws_security_group" "sg" {
  filter {
    name   = "group-name"
    values = ["bh_sg01"]
  }
}

data "aws_key_pair" "key_pair" {
  key_name = var.key_name
  # public_key = file(var.public_key_path)
}

data "aws_subnet" "private_subnet" {
  filter {
  name   = "tag:name"
  values = ["default_us-east1a"]
}
}
