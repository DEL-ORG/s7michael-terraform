# Specify the required plugin for Amazon AWS
packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Define variables for region, instance type, AMI ID, and SSH username
variable "aws_region" {
  type    = string
  default = "us-east-1" # Change to your preferred AWS region
}

variable "instance_type" {
  type    = string
  default = "t2.micro" # Specify the instance type
}

variable "source_ami" {
  type    = string
  default = "ami-0866a3c8686eaeeba" # Replace with an Ubuntu AMI ID for your region
}

variable "ssh_username" {
  type    = string
  default = "ubuntu" # Default user for Ubuntu instances
}

# Define the builder to create an AMI on AWS
source "amazon-ebs" "jenkins-ami" {
  region                      = "us-east-1"
  instance_type               = "t2.micro"
  source_ami                  = "ami-0866a3c8686eaeeba" # Replace with the appropriate Ubuntu AMI ID
  ami_name                    = "ubuntu-ami-{{timestamp}}"
  ami_description             = "Ubuntu AMI with Jenkins installed"
  ssh_username                = "ubuntu" # Default user for Ubuntu AMIs
  associate_public_ip_address = true

  tags = {
    Name        = "Jenkins AMI"
    Environment = "Dev"
  }
}


# Define the provisioner to install Jenkins on the instance
build {
  sources = ["source.amazon-ebs.jenkins-ami"]
  provisioner "shell" {
    inline = [
      "echo 'Updating package lists...'",
      "sudo apt update -y",
      "echo 'Installing dependencies...'",
      "sudo apt install -y curl openjdk-11-jdk", # Install curl and Java dependencies
      "echo 'Adding Jenkins GPG key...'",
      "curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo gpg --dearmor -o /usr/share/keyrings/jenkins-keyring.gpg", # Add the GPG key
      "echo 'Adding Jenkins repository...'",
      "echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.gpg] https://pkg.jenkins.io/debian-stable binary/' | sudo tee /etc/apt/sources.list.d/jenkins.list", # Add Jenkins repo with key
      "echo 'Updating package lists again...'",
      "sudo apt update -y", # Update after adding the Jenkins repo
      "echo 'Installing Jenkins...'",
      "sudo apt install -y jenkins", # Install Jenkins
      "echo 'Starting Jenkins service using service command...'",
      "sudo service jenkins start",           # Start Jenkins service using 'service'
      "sudo systemctl enable jenkins || true" # Enable Jenkins on boot if possible
    ]
  }


}
