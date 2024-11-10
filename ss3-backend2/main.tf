# Configure the AWS provider
provider "aws" {
  region = "us-east-1"  # Specify your AWS region
}

# Create an S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "your-unique-bucket-name"  # Replace with a unique bucket name

  versioning {
    enabled = true  # Enable versioning for state file history
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "dev"
  }
}

# Optional: Create a DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock-table"  # DynamoDB table for locking
  billing_mode = "PAY_PER_REQUEST"       # Automatically scales capacity
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "dev"
  }
}

# Set the S3 backend for Terraform to use the newly created bucket and DynamoDB table
terraform {
  backend "s3" {
    bucket         = aws_s3_bucket.terraform_state.bucket
    key            = "terraform/state.tfstate"  # Path within the bucket
    region         = "us-east-1"
    dynamodb_table = aws_dynamodb_table.terraform_lock.name
    encrypt        = true
  }
}
