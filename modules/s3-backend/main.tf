
resource "aws_s3_bucket" "source_bucket" {
  bucket = format("%s-%s-%s", var.tags["environment"], var.tags
  ["project"], var.source_bucket)

    versioning {
    enabled = true
  }

  tags = merge (var.tags, {
  Name = format("%s-%s-%s", var.tags["environment"], var.tags["project"], var.source_bucket)})
}

resource "aws_s3_bucket" "replica_bucket" {
  bucket = format("%s-%s-%s", var.tags["environment"], var.tags
  ["project"], var.replica_bucket)

  versioning {
    enabled = true
  }

  tags = merge (var.tags, {
  Name = format("%s-%s-%s", var.tags["environment"], var.tags
  ["project"], var.replica_bucket)})
}

resource "aws_s3_bucket_policy" "source_bucket_policy" {
  bucket = aws_s3_bucket.source_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowReplication"
        Effect    = "Allow"
        Principal = {
          AWS = aws_iam_role.replication_role.arn
        }
        Action    = "s3:ReplicateObject"
        Resource  = "${aws_s3_bucket.source_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "replica_bucket_policy" {
  bucket = aws_s3_bucket.replica_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowReplicationDestination"
        Effect    = "Allow"
        Principal = {
          AWS = aws_iam_role.replication_role.arn
        }
        Action    = "s3:ReplicateObject"
        Resource  = "${aws_s3_bucket.replica_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_iam_role" "replication_role" {
  name               = var.replication_role
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
}

resource "aws_iam_policy" "replication_policy" {
  name   = var.replication_policy
  policy = data.aws_iam_policy_document.replication_policy.json
}

resource "aws_iam_role_policy_attachment" "replication_policy_attachment" {
  role       = aws_iam_role.replication_role.name
  policy_arn = aws_iam_policy.replication_policy.arn
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  bucket = aws_s3_bucket.source_bucket.id
  role = aws_iam_role.replication_role.arn

  rule {
    id     = "replication-rule"
    status = "Enabled"

     filter {
      prefix = ""
    }

    destination {
      bucket        = "arn:aws:s3:::${aws_s3_bucket.replica_bucket.id}"
      storage_class = "STANDARD"  
    }

    delete_marker_replication {
      status = "Disabled" # Or "Enabled" if required
    }
  }
}

data "aws_iam_policy_document" "trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
        type        = "Service"
        identifiers = ["s3.amazonaws.com"]
      }
  }
}

data "aws_iam_policy_document" "replication_policy" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [
      "${aws_s3_bucket.source_bucket.arn}/*",
      "${aws_s3_bucket.replica_bucket.arn}/*"
    ]
  }
}

resource "aws_dynamodb_table" "state_lock_table" {
  name         = format("%s-%s-%s", var.tags["environment"], var.tags
  ["project"], var.state_lock_table)
  hash_key     = "LockID"                
  read_capacity  = 5                     
  write_capacity = 5                     
  billing_mode  = "PROVISIONED"          

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = merge (var.tags, {
  Name = format("%s-%s-%s", var.tags["environment"], var.tags
  ["project"], var.source_bucket)})  
}

resource "aws_iam_role" "terraform_state_role" {
  name               = var.terraform_state_role
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
}

data "aws_iam_policy_document" "state_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
    ]
    resources = [
      "${aws_s3_bucket.source_bucket.arn}",
      "${aws_s3_bucket.replica_bucket.arn}/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:DeleteItem",
      "dynamodb:UpdateItem",
      "dynamodb:DescribeTable",
    ]
    resources = [
      "${aws_dynamodb_table.state_lock_table.arn}",
    ]
  }
}

resource "aws_iam_policy" "terraform_state_policy" {
  name   = var.terraform_state_policy
  policy = data.aws_iam_policy_document.state_policy.json
}

resource "aws_iam_role_policy_attachment" "terraform_state_policy_attachment" {
  role       = aws_iam_role.terraform_state_role.name
  policy_arn = aws_iam_policy.terraform_state_policy.arn
}






















# Step 2: Configure Backend for State Locking (using DynamoDB)
# terraform {
  # backend "s3" {
    # bucket = "your-s3-bucket-name"  # The name of your S3 bucket for storing the state file
    # key    = "path/to/terraform.tfstate"  # Path to the state file within the S3 bucket
    # region = var.region  # Specify the region
    # encrypt = true  # Encrypt state file
    # dynamodb_table = aws_dynamodb_table.state_lock_table.name  # Link to the DynamoDB table for state locking
  # }
# }
