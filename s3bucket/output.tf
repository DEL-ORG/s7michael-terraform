output "bucket_name" {
  value       = aws_s3_bucket.michael-bucket02.bucket
  description = "The name of the S3 bucket"
}
