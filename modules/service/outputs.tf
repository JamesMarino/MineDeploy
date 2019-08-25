output "backup_bucket_name" {
  value = aws_s3_bucket.mine_deploy_backup_bucket.id
}

output "backup_bucket_arn" {
  value = aws_s3_bucket.mine_deploy_backup_bucket.arn
}
