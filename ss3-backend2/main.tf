
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock-table" # DynamoDB table for locking
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
