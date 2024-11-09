# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Define the S3 bucket for the Terraform backend
resource "aws_s3_bucket" "terraform_state" {
  bucket = "s7michael-bucket" # Replace with a unique bucket name

  tags = {
    Name        = "s7michael-bucket"
    Environment = "dev"
  }
}

# Define a DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-state-lock" # DynamoDB table for locking
  billing_mode = "PAY_PER_REQUEST"      # Automatically scales capacity
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

# Define an IAM policy to control access to the S3 bucket and DynamoDB table
resource "aws_iam_policy" "terraform_state_policy" {
  name        = "TerraformStatePolicy"
  description = "Policy for accessing the S3 bucket and DynamoDB table for Terraform state management"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:ListBucket"],
        Resource = [aws_s3_bucket.terraform_state.arn]
      },
      {
        Effect   = "Allow",
        Action   = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Resource = ["${aws_s3_bucket.terraform_state.arn}/*"]
      },
      {
        Effect   = "Allow",
        Action   = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:DeleteItem",
          "dynamodb:DescribeTable"
        ],
        Resource = [aws_dynamodb_table.terraform_lock.arn]
      }
    ]
  })
}

# Backend configuration should be placed in a separate file or manual configuration
# You do NOT configure the backend directly in this block.
# Instead, when you run `terraform init`, manually configure the backend as follows:
# 
# terraform init \
#  -backend-config="bucket=s7michael-bucket" \
#  -backend-config="key=terraform/state.tfstate" \
#  -backend-config="region=us-east-1" \
#  -backend-config="dynamodb_table=terraform-state-lock" \
#  -backend-config="encrypt=true"
