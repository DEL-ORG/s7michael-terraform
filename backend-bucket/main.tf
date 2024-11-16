

# Configure the backend to use an existing S3 bucket and DynamoDB table for locking
terraform {
  backend "s3" {
    bucket         = "michael-bucket02"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock02"
    encrypt        = true
  }
}


resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-state-lock02"
  billing_mode = "PAY_PER_REQUEST"
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


resource "aws_iam_policy" "s3_dynamodb_policy" {
  name        = "S3DynamoDBPolicy"
  description = "Policy to allow access to S3 bucket and DynamoDB table for Terraform state"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = "arn:aws:s3:::michael-bucket02" # Replace with your bucket's ARN
      },
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::michael-bucket02/*" # Allow access to objects in the bucket
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:DeleteItem",
          "dynamodb:DescribeTable"
        ]
        Resource = "arn:aws:dynamodb:us-east-1:YOUR_ACCOUNT_ID:table/terraform-state-lock" # Replace with your DynamoDB table ARN
      }
    ]
  })
}

# Attach the policy to an IAM role for Terraform (if needed)
# resource "aws_iam_role" "terraform_role" {
#   name = "terraform-backend-role"
#   assume_role_policy = jsonencode({
# Version = "2012-10-17"
# Statement = [
#   {
# Effect = "Allow"
# Principal = {
#   Service = "ec2.amazonaws.com"
# }
# Action = "sts:AssumeRole"
#   }
# ]
#   })
# }
# 
# resource "aws_iam_role_policy_attachment" "terraform_role_policy_attachment" {
#   role       = aws_iam_role.terraform_role.name
#   policy_arn = aws_iam_policy.s3_dynamodb_policy.arn
# }
# 