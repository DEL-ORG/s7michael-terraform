
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}


variable "environment" {
  description = "The environment for the bucket (e.g., Dev, Test, Prod)"
  type        = string
  default     = "Dev" 
}


variable "bucket_tags" {
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default = {
    Name = "My S3 Bucket"
  }
}
