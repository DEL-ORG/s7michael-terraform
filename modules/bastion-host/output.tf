
# output "ec2_public_ip" {
# value = aws_instance.my-console.public_ip
# }

# output "vpc_id" {
  # value = data.aws_vpc.selected_vpc.id
# }

output "ubuntu_ami" {
  value = data.aws_ami.ubuntu_ami.id
}

output "aws_subnet" {
  value = data.aws_subnet.subnet-01.id
}

output "key_name" {
  value = data.aws_key_pair.key_pair.key_name
}

output "vpc_security_group_ids" {
  value = data.aws_security_group.sg.id
}
