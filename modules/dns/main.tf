resource "aws_route53_health_check" "mine_deploy_health_check" {
  tags = {
    Name = var.host_name
  }
  type              = "TCP"
  port              = 25565
  fqdn              = var.host_name
  request_interval  = 30
  failure_threshold = 3
}

resource "aws_cloudwatch_metric_alarm" "mine_deploy_cloudwatch_metric_alarm" {
  actions_enabled = true
  alarm_actions = [

  ]
  alarm_description   = "MineDeployHealthCheckAlarm"
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    HealthCheckId = aws_route53_health_check.mine_deploy_health_check.id
  }
  evaluation_periods = 2
  metric_name        = "HealthCheckStatus"
  namespace          = "AWS/Route53"
  ok_actions = [

  ]
  period             = 60
  statistic          = "Minimum"
  alarm_name         = "MineDeployHealthCheck"
  treat_missing_data = "notBreaching"
  threshold          = 1.0
}

resource "aws_sns_topic" "mine_deploy_sns_topic" {
  display_name = "MineDeployNotificationTopic"
  name_prefix  = "mine-topic-"
}

resource "aws_sns_topic_subscription" "mine_deploy_sns_topic_subscription" {
  endpoint  = var.alerts_mobile_number
  protocol  = "sms"
  topic_arn = aws_sns_topic.mine_deploy_sns_topic.arn
}
