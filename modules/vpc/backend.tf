terraform {
  backend "s3" {
    bucket         = "s7michael-1"
    key            = "vpc/terraform.tfstate" # Adjust the path as needed
    region         = "us-east-1"
    # dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
