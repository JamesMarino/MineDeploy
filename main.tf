provider "aws" {
  region = var.aws_region
}

locals {
  aws_region                   = var.aws_region
  aws_region_availability_zone = var.aws_region_availability_zone
}

module "service" {
  source = "./modules/service"

  aws_region                             = local.aws_region
  availability_zone                      = local.aws_region_availability_zone
  environment_name                       = var.environment_name
  host_name                              = var.host_name
  key_name                               = var.key_name
  mine_deploy_load_balancer_target_group = module.networking.mine_deploy_alb_target_group
  mine_deploy_vpc                        = module.networking.mine_deploy_vpc_id
  mine_deploy_subnet                     = module.networking.mine_deploy_subnet
  minecraft_admin_players                = var.minecraft_admin_players
  minecraft_allow_flight                 = var.minecraft_allow_flight
  minecraft_allow_nether                 = var.minecraft_allow_nether
  minecraft_difficulty                   = var.minecraft_difficulty
  minecraft_enable_command_blocks        = var.minecraft_enable_command_blocks
  minecraft_generate_structures          = var.minecraft_generate_structures
  minecraft_memory_limit                 = var.minecraft_memory_limit
  minecraft_message_of_the_day           = var.minecraft_message_of_the_day
  minecraft_mode                         = var.minecraft_mode
  minecraft_server_name                  = var.minecraft_server_name
  minecraft_spawn_animals                = var.minecraft_spawn_animals
  minecraft_spawn_npcs                   = var.minecraft_spawn_npcs
  minecraft_world_zip_url                = var.minecraft_world_zip_url
}

module "networking" {
  source = "./modules/networking"

  availability_zone = local.aws_region_availability_zone
}

module "dns" {
  source = "./modules/dns"

  alb_dns_name         = var.alb_dns_name
  alerts_mobile_number = var.alerts_mobile_number
  host_name            = var.host_name
}

module "sftp" {
  source = "./modules/sftp"

  backup_bucket_name   = module.service.backup_bucket_name
  backup_bucket_arn    = module.service.backup_bucket_arn
  sftp_user            = var.sftp_user
  sftp_user_public_key = var.sftp_user_public_key
}
