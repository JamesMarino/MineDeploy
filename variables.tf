variable "aws_region" {
  type    = "string"
  default = "ap-southeast-2"
}

variable "aws_region_availability_zone" {
  type    = "string"
  default = "ap-southeast-2a"
}

variable "environment_name" {}
variable "host_name" {}
variable "key_name" {}
variable "minecraft_admin_players" {}
variable "minecraft_allow_flight" {}
variable "minecraft_allow_nether" {}
variable "minecraft_difficulty" {}
variable "minecraft_enable_command_blocks" {}
variable "minecraft_generate_structures" {}
variable "minecraft_memory_limit" {}
variable "minecraft_message_of_the_day" {}
variable "minecraft_mode" {}
variable "minecraft_server_name" {}
variable "minecraft_spawn_animals" {}
variable "minecraft_spawn_npcs" {}
variable "minecraft_world_zip_url" {}
variable "alb_dns_name" {}
variable "alerts_mobile_number" {}
variable "sftp_user" {}
variable "sftp_user_public_key" {}
