#!/bin/bash

yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
/usr/bin/enable-ec2-spot-hibernation
docker plugin install rexray/ebs REXRAY_PREEMPT=true EBS_REGION=${aws_region} --grant-all-permissions
echo ECS_CLUSTER=${mine_deploy_cluster_name} >> /etc/ecs/ecs.config
