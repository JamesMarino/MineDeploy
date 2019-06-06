# Mine Deploy Backup Script

Note - EBS can only be accessed through an AWS VPC. Make sure you are running
the following on an EC2 instance in your VPC.

## Building and Running

```bash
docker build -t minedeploy/backup:latest .
docker run \
    --env INSTANCE_NAME=test-namespace \
    --env S3_BUCKET_NAME=test-backups-bucket \
    --env AWS_ACCESS_KEY_ID=AKIA123 \
    --env AWS_SECRET_ACCESS_KEY=qwerty \
    --volume TestVolume:/data \
    mine-deploy-backup:latest
```

## Testing Using Volume on Amazon EC2

### Install Docker Amazon Linux

```bash
sudo yum update -y
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
docker info
```

### Install Docker

```bash
docker plugin install rexray/ebs \
    --grant-all-permissions \
    EBS_REGION=ap-southeast-2 \
    EBS_ACCESSKEY=AKIA123 \
    EBS_SECRETKEY=qwerty

docker volume create \
    --driver rexray/ebs \
    --name TestVolume

docker run \
    --name alpine \
    --interactive \
    --tty \
    --volume TestVolume:/data \
    alpine /bin/ash

docker exec \
    --interactive \
    --tty \
    alpine /bin/ash
```
