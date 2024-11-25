
resource "aws_s3_bucket" "michael-bucket02" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  tags = {
    Name        = "My S3 Bucket"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "michael-bucket02_policy" {
  name = "terraform_state_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.michael-bucket02.arn}/*"
      }
    ]
  })
}

