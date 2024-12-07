output "source_bucket_arn" {
  description = "ARN of the primary S3 bucket"
  value       = aws_s3_bucket.source_bucket.arn
}

output "replica_bucket_arn" {
  description = "ARN of the replica S3 bucket"
  value       = aws_s3_bucket.replica_bucket.arn
}

output "replication_role_arn" {
  description = "ARN of the IAM role for S3 replication"
  value       = aws_iam_role.replication_role.arn
}
