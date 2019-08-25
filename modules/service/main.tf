resource "aws_ecs_cluster" "mine_deploy_cluster" {
  name = "mine-deploy"
}

resource "aws_ecs_service" "mine_deploy_service" {
  name            = "mine-deploy"
  task_definition = aws_ecs_task_definition.mine_deploy_task_definition.arn
  cluster         = aws_ecs_cluster.mine_deploy_cluster.id
  desired_count   = 1
  launch_type     = "EC2"

  load_balancer {
    container_name   = var.mine_deploy_container_name
    container_port   = 25565
    target_group_arn = var.mine_deploy_load_balancer_target_group
  }
}

resource "aws_ebs_volume" "mine_deploy_volume" {
  availability_zone = var.availability_zone
  size              = 8
}

resource "aws_ecs_task_definition" "mine_deploy_task_definition" {
  container_definitions = templatefile("${path.module}/templates/container_definition_mine_deploy.tmpl", {
    minecraft_memory_limit          = var.minecraft_memory_limit
    minecraft_server_name           = var.minecraft_server_name
    minecraft_difficulty            = var.minecraft_difficulty
    minecraft_allow_nether          = var.minecraft_allow_nether
    minecraft_generate_structures   = var.minecraft_generate_structures
    minecraft_spawn_animals         = var.minecraft_spawn_animals
    minecraft_spawn_npcs            = var.minecraft_spawn_npcs
    minecraft_message_of_the_day    = var.minecraft_message_of_the_day
    minecraft_allow_flight          = var.minecraft_allow_flight
    minecraft_mode                  = var.minecraft_mode
    minecraft_enable_command_blocks = var.minecraft_enable_command_blocks
    minecraft_admin_players         = var.minecraft_admin_players
    minecraft_world_zip_url         = var.minecraft_world_zip_url
    mine_deploy_container_name      = var.mine_deploy_container_name
    aws_region                      = var.aws_region
    minecraft_service_name          = "mine-deploy"
    mine_deploy_volume_name         = aws_ebs_volume.mine_deploy_volume.id
    mine_deploy_log_group           = aws_cloudwatch_log_group.mine_deploy_cloudwatch_log_group.name
  })
  family = "mine-deploy"
  cpu    = "1920"
  memory = "7721"

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone==${var.availability_zone}"
  }

  volume {
    name = aws_ebs_volume.mine_deploy_volume.id
    docker_volume_configuration {
      autoprovision = true
      scope         = "shared"
      driver        = "rexray/ebs"

      driver_opts = {
        volumetype = "gp2"
        size       = "5"
      }
    }
  }
}

resource "aws_s3_bucket" "mine_deploy_backup_bucket" {
  bucket_prefix = "mine-deploy-"
  acl           = "public-read"

  lifecycle_rule {
    expiration {
      days = 3
    }
    enabled = false
  }
}

resource "aws_s3_bucket_policy" "mine_deploy_backup_bucket_policy" {
  bucket = aws_s3_bucket.mine_deploy_backup_bucket.id
  policy = templatefile("${path.module}/templates/backup_bucket_policy.tmpl", {
    backup_bucket_arn = aws_s3_bucket.mine_deploy_backup_bucket.arn
  })
}

resource "aws_ecs_task_definition" "mine_deploy_backup_task_definition" {
  container_definitions = templatefile("${path.module}/templates/container_definition_mine_deploy_backup.tmpl", {
    minecraft_backup_instance_name = var.environment_name
    minecraft_volume_name          = aws_ebs_volume.mine_deploy_volume.id
    aws_region                     = var.aws_region
    availability_zone              = var.availability_zone
    minecraft_backup_bucket_name   = aws_s3_bucket.mine_deploy_backup_bucket.bucket
    minecraft_backup_service_name  = aws_ecs_service.mine_deploy_service.name
    mine_deploy_log_group          = aws_cloudwatch_log_group.mine_deploy_cloudwatch_log_group.name
  })
  family = "mine-deploy-backup"
  cpu    = "512"
  memory = "1024"
  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone==${var.availability_zone}"
  }
  volume {
    name      = "TempVolume"
    host_path = "/root/backup"
  }
  volume {
    name      = "DockerSocket"
    host_path = "/var/run/docker.sock"
  }
}

resource "aws_cloudwatch_event_rule" "mine_deploy_cloudwatch_event_rule" {
  name                = "mine-deploy-backup-rule-${var.host_name}"
  description         = "Minecraft data backup every hour"
  schedule_expression = "rate(1 hour)"
  is_enabled          = true
}

resource "aws_cloudwatch_event_target" "mine_deploy_cloudwatch_event_target" {
  arn      = aws_ecs_cluster.mine_deploy_cluster.arn
  rule     = aws_cloudwatch_event_rule.mine_deploy_cloudwatch_event_rule.name
  role_arn = aws_iam_role.mine_deploy_task_scheduler_role.arn

  ecs_target {
    task_definition_arn = aws_ecs_task_definition.mine_deploy_backup_task_definition.arn
    task_count          = 1
  }
}

resource "aws_cloudwatch_log_group" "mine_deploy_cloudwatch_log_group" {
  name_prefix       = "${var.host_name}-"
  retention_in_days = 365
}

resource "aws_autoscaling_group" "mine_deploy_autoscaling_group" {
  name_prefix          = "md-asg-"
  launch_configuration = aws_launch_configuration.mine_deploy_launch_configuration.name
  availability_zones = [
  var.availability_zone]
  desired_capacity = 2
  max_size         = 2
  min_size         = 1
  vpc_zone_identifier = [
  var.mine_deploy_subnet]
}

resource "aws_security_group" "mine_deploy_security_group" {
  description = "Mine Deploy All Traffic"
  vpc_id      = var.mine_deploy_vpc

  ingress {
    cidr_blocks = [
    "0.0.0.0/0"]
    from_port = 0
    protocol  = "TCP"
    to_port   = 65535
  }

  egress {
    cidr_blocks = [
    "0.0.0.0/0"]
    from_port = 0
    protocol  = "TCP"
    to_port   = 65535
  }
}

resource "aws_iam_role" "mine_deploy_task_scheduler_role" {
  name_prefix        = "task-scheduler-role-"
  assume_role_policy = file("${path.module}/templates/task_scheduler_assume_role_policy.tmpl")
  path               = "/"
}

resource "aws_iam_role_policy_attachment" "mine_deploy_task_scheduler_role_policyrole_attachment" {
  role       = aws_iam_role.mine_deploy_task_scheduler_role.name
  policy_arn = aws_iam_policy.mine_deploy_task_scheduler_policy.arn
}

resource "aws_iam_policy" "mine_deploy_task_scheduler_policy" {
  name_prefix = "task-scheduler-policy-"
  policy      = file("${path.module}/templates/task_scheduler_policy.tmpl")
}

resource "aws_iam_role" "mine_deploy_ec2_role" {
  name_prefix        = "ec2-role-"
  assume_role_policy = file("${path.module}/templates/ec2_assume_role_policy.tmpl")
  path               = "/"
}

resource "aws_iam_role_policy_attachment" "mine_deploy_ec2_role_policyrole_attachment" {
  role       = aws_iam_role.mine_deploy_ec2_role.name
  policy_arn = aws_iam_policy.mine_deploy_ec2_policy.arn
}

resource "aws_iam_policy" "mine_deploy_ec2_policy" {
  name_prefix = "ec2-policy-"
  policy      = file("${path.module}/templates/ec2_policy.tmpl")
}

resource "aws_iam_instance_profile" "mine_deploy_instance_profile" {
  path = "/"
  role = aws_iam_role.mine_deploy_ec2_role.id
}

resource "aws_launch_configuration" "mine_deploy_launch_configuration" {
  name_prefix          = "tf-lc-"
  key_name             = var.key_name
  image_id             = var.ecs_ami
  instance_type        = "m4.large"
  iam_instance_profile = aws_iam_instance_profile.mine_deploy_instance_profile.id
  security_groups = [
    aws_security_group.mine_deploy_security_group.id
  ]
  user_data = templatefile("${path.module}/templates/user_data.sh", {
    aws_region               = var.aws_region
    mine_deploy_cluster_name = aws_ecs_cluster.mine_deploy_cluster.name
  })
  associate_public_ip_address = true
}
