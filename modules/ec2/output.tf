
# output "ec2_public_ip" {
# value = aws_instance.my-console.public_ip
# }

output "vpc_id" {
  value = data.aws_vpc.selected_vpc.id
}

output "ami_id" {
  value = data.aws_ami.ec2_ami.id
}

output "aws_subnet" {
  value = data.aws_subnet.subnet-01.id
}

