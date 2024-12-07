variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "source_bucket" {
  description = "Name of the primary S3 bucket"
  type        = string
}

variable "replica_bucket" {
  description = "Name of the replica S3 bucket"
  type        = string
}

variable "replication_role" {
  description = "Name of iam role for replication"
  type        = string
}

variable "replication_policy" {
  description = "Name of iam policy for replication"
  type        = string
  default     = "replication_policy"
}

variable "terraform_state_role" {
  type        = string
}

variable "terraform_state_policy" {
  type        = string
}

variable "state_lock_table" {
  type        = string
}

variable "tags" {
  type        = map(string)
}

variable "prevent_destroy" {
  description = "Prevent bucket destruction"
  type        = bool
  default     = true
}
