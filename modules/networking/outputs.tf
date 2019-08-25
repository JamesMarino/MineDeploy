output "mine_deploy_vpc_id" {
  value       = aws_vpc.mine_deploy_vpc.id
  description = "Mine Deploy VPC"
}

output "mine_deploy_subnet" {
  value       = aws_subnet.mine_deploy_subnet.id
  description = "Mine Deploy Subnet"
}

output "mine_deploy_alb" {
  value       = aws_alb.mine_deploy_alb.id
  description = "Mine Deploy Load Balancer"
}

output "mine_deploy_alb_target_group" {
  value       = aws_alb_target_group.mine_deploy_alb_target_group.id
  description = "Mine Deploy Load Balancer Target Group"
}

output "mine_deploy_alb_dns_name" {
  value       = aws_alb.mine_deploy_alb.dns_name
  description = "Mine Deploy Load Balancer DNS Name"
}

output "mine_deploy_alb_name" {
  value       = aws_alb.mine_deploy_alb.name
  description = "Mine Deploy Load Balancer ALB Name"
}

output "mine_deploy_alb_hosted_zone" {
  value       = aws_alb.mine_deploy_alb.zone_id
  description = "Mine Deploy Load Balancer Hosted Zone"
}
