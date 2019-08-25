variable "aws_region" {
  type        = "string"
  description = "AWS Region"
}

variable "host_name" {
  type        = "string"
  description = "Hostname such as example.com"
}

variable "environment_name" {
  type        = "string"
  description = "Environment Name"
}

variable "mine_deploy_vpc" {
  type        = "string"
  description = "Mine Deploy ECS VPC"
}

variable "mine_deploy_subnet" {
  type        = "string"
  description = "Mine Deploy ECS Subnet"
}

variable "mine_deploy_load_balancer_target_group" {
  type        = "string"
  description = "Mine Deploy Load Balancer Name"
}

variable "mine_deploy_container_name" {
  type        = "string"
  description = "Mine Deploy Container Name"
  default     = "MineDeploy"
}

variable "key_name" {
  type        = "string"
  description = "Mine Deploy EC2 Box Keys"
}

variable "availability_zone" {
  type        = "string"
  description = "Availability Zone"
}

variable "ecs_ami" {
  type        = "string"
  description = "Hostname such as example.com"
  default     = "ami-0c7dea114481e059d"
}

variable "minecraft_server_name" {
  type        = "string"
  description = "Minecraft Server Name"
}

variable "minecraft_difficulty" {
  type        = "string"
  description = "Minecraft Difficulty"
}

variable "minecraft_allow_nether" {
  type        = "string"
  description = "Minecraft Nether"
}

variable "minecraft_generate_structures" {
  type        = "string"
  description = "Minecraft Generate Structures"
}

variable "minecraft_spawn_animals" {
  type        = "string"
  description = "Minecraft Spawn Animals"
}

variable "minecraft_spawn_npcs" {
  type        = "string"
  description = "Hostname such as example.com"
}

variable "minecraft_message_of_the_day" {
  type        = "string"
  description = "Hostname such as example.com"
}

variable "minecraft_allow_flight" {
  type        = "string"
  description = "Minecraft Allow Flight"
}

variable "minecraft_enable_command_blocks" {
  type        = "string"
  description = "Minecraft Allow Command Block"
}

variable "minecraft_mode" {
  type        = "string"
  description = "Minecraft Allow Command Block"
}

variable "minecraft_admin_players" {
  type        = "string"
  description = "Minecraft mode, survival or creative"
}

variable "minecraft_world_zip_url" {
  type        = "string"
  description = "Minecraft mode, survival or creative"
  default     = ""
}

variable "minecraft_memory_limit" {
  type        = "string"
  description = "Hard Memory Limit for Java"
}
