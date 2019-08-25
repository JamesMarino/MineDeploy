resource "aws_vpc" "mine_deploy_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "mine_deploy_internet_gateway" {
  vpc_id = aws_vpc.mine_deploy_vpc.id
}

resource "aws_route_table" "mine_deploy_route_table" {
  vpc_id = aws_vpc.mine_deploy_vpc.id
}

resource "aws_route" "mine_deploy_route" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mine_deploy_internet_gateway.id
  route_table_id         = aws_route_table.mine_deploy_route_table.id
}

resource "aws_subnet" "mine_deploy_subnet" {
  availability_zone       = var.availability_zone
  cidr_block              = "10.0.0.0/16"
  vpc_id                  = aws_vpc.mine_deploy_vpc.id
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "mine_deploy_route_table_association" {
  route_table_id = aws_route_table.mine_deploy_route_table.id
  subnet_id      = aws_subnet.mine_deploy_subnet.id
}

resource "aws_alb" "mine_deploy_alb" {
  ip_address_type    = "ipv4"
  internal           = false
  name_prefix        = "mn-lb-"
  subnets            = [aws_subnet.mine_deploy_subnet.id]
  load_balancer_type = "network"
}

resource "aws_alb_listener" "mine_deploy_alb_lister" {
  load_balancer_arn = aws_alb.mine_deploy_alb.arn
  port              = 25565
  protocol          = "TCP"
  default_action {
    target_group_arn = aws_alb_target_group.mine_deploy_alb_target_group.arn
    type             = "forward"
  }
}

resource "aws_alb_target_group" "mine_deploy_alb_target_group" {
  port     = 25565
  protocol = "TCP"
  vpc_id   = aws_vpc.mine_deploy_vpc.id
}
