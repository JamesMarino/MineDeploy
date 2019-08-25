resource "aws_iam_role" "mine_deploy_sftp_iam_role" {
  name_prefix        = "sftp-role-"
  assume_role_policy = templatefile("${path.module}/templates/sftp_role.tmpl", {})
}

resource "aws_iam_role_policy" "mine_deploy_sftp_iam_role_policy" {
  name_prefix = "sftp-role-policy-"
  role        = aws_iam_role.mine_deploy_sftp_iam_role.id
  policy      = templatefile("${path.module}/templates/sftp_role_policy.tmpl", {})
}

resource "aws_transfer_server" "mine_deploy_sftp" {
  identity_provider_type = "SERVICE_MANAGED"
  logging_role           = aws_iam_role.mine_deploy_sftp_iam_role.arn
  endpoint_type          = "PUBLIC"
}

resource "aws_iam_role" "mine_deploy_user_iam_role" {
  name_prefix        = "sftp-user-role-"
  assume_role_policy = templatefile("${path.module}/templates/sftp_user_role.tmpl", {})
}

resource "aws_iam_role_policy" "mine_deploy_user_iam_role_policy" {
  name_prefix = "sftp-user-role-policy-"
  role        = aws_iam_role.mine_deploy_user_iam_role.id
  policy = templatefile("${path.module}/templates/stfp_user_role_policy.tmpl", {
    backup_bucket_arn = var.backup_bucket_arn
  })
}

resource "aws_transfer_user" "mine_deploy_transfer_user" {
  home_directory = "/${var.backup_bucket_name}"
  server_id      = aws_transfer_server.mine_deploy_sftp.id
  user_name      = var.sftp_user
  role           = aws_iam_role.mine_deploy_user_iam_role.arn
}

resource "aws_transfer_ssh_key" "mine_deploy_transfer_user_ssh_key" {
  server_id = aws_transfer_server.mine_deploy_sftp.id
  user_name = aws_transfer_user.mine_deploy_transfer_user.user_name
  body      = var.sftp_user_public_key
}
