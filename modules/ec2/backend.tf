# Set the S3 backend for Terraform to use the newly created bucket and DynamoDB table
terraform {
  backend "s3" {
    bucket = "s7michael-1"
    key    = "ec2/terraform.tfstate" # Path within the bucket
    region = "us-east-1"
    # dynamodb_table = "terraform-lock-table"
    encrypt = true
  }
}
