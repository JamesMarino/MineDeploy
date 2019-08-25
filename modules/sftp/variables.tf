variable "backup_bucket_name" {
  type        = "string"
  description = "Name of the Backup Bucket"
}

variable "backup_bucket_arn" {
  type        = "string"
  description = "ARN of the Backup Bucket"
}

variable "sftp_user" {
  type        = "string"
  description = "SFTP User Name"
}

variable "sftp_user_public_key" {
  type        = "string"
  description = "SFTP User Public Key"
}
