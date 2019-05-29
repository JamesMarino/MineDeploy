#!/usr/bin/env bash

# Docs:
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html

lsblk
sudo mkdir /data
sudo mount /dev/xvdf /data
