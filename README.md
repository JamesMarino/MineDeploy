# Mine Deploy

CloudFormation Stack Minecraft Server Deployment on ECS.

Easy and quick way to get Minecraft running on AWS.

## Notes

When updating the CloudFormation stack set desired instances to 2 in AutoScaling due
to Reserved CPU and Memory allocation at it's maximum.

## Deployment

1.  Package

```bash
aws cloudformation package \
    --template-file src/minedeploy.cloudformation.json \
    --s3-prefix minedeploy \
    --s3-bucket cloud-nested-templates \
    --output-template-file src/minedeploy.deploy.cloudformation.yaml \
    --profile default \
    --region us-east-1
```

2.  Validate

```bash
aws cloudformation validate-template \
    --template-body file://./src/minedeploy.deploy.cloudformation.yaml
```

3.  Deploy

a) Create

**Warning: Package Before Deploying**

```bash
aws cloudformation create-stack \
	--stack-name MineDeploy \
	--template-body file://./src/minedeploy.deploy.cloudformation.yaml \
	--parameters ParameterKey=HostName,ParameterValue=example.com \
	             ParameterKey=AvailabilityZone,ParameterValue=ap-southeast-2a \
	             ParameterKey=MineDeployVolumeName,ParameterValue=ExampleVolumeName \
	             ParameterKey=HostedZoneId,ParameterValue=ABC123 \
	             ParameterKey=MineDeployLoadBalancerName,ParameterValue=example-loadbalancer \
	             ParameterKey=KeyName,ParameterValue=JamesMarino \
	             ParameterKey=ServerName,ParameterValue=MyServer \
	             ParameterKey=Difficulty,ParameterValue=peaceful \
	             ParameterKey=AllowNether,ParameterValue=TRUE \
	             ParameterKey=GenerateStructures,ParameterValue=TRUE \
	             ParameterKey=SpawnAnimals,ParameterValue=TRUE \
	             ParameterKey=SpawnNPCs,ParameterValue=TRUE \
	             ParameterKey=MessageOfTheDay,ParameterValue=Message \
	             ParameterKey=AllowFlight,ParameterValue=TRUE \
	             ParameterKey=Mode,ParameterValue=creative \
	             ParameterKey=WorldZIPUrl,ParameterValue=https://example.com/file.zip \
	--capabilities CAPABILITY_IAM \
	--profile default \
	--region ap-southeast-2
```

b) Update

**Warning: Package Before Updating**

```bash
aws cloudformation update-stack \
	--stack-name MineDeploy \
	--template-body file://./src/minedeploy.deploy.cloudformation.yaml \
	--parameters ParameterKey=HostName,ParameterValue=example.com \
	             ParameterKey=AvailabilityZone,ParameterValue=ap-southeast-2a \
	             ParameterKey=MineDeployVolumeName,ParameterValue=ExampleVolumeName \
                 ParameterKey=HostedZoneId,ParameterValue=ABC123 \
	             ParameterKey=MineDeployLoadBalancerName,ParameterValue=example-loadbalancer \
	             ParameterKey=KeyName,ParameterValue=JamesMarino \
	             ParameterKey=ServerName,ParameterValue=MyServer \
	             ParameterKey=Difficulty,ParameterValue=peaceful \
	             ParameterKey=AllowNether,ParameterValue=TRUE \
	             ParameterKey=GenerateStructures,ParameterValue=TRUE \
	             ParameterKey=SpawnAnimals,ParameterValue=TRUE \
	             ParameterKey=SpawnNPCs,ParameterValue=TRUE \
	             ParameterKey=MessageOfTheDay,ParameterValue=Message \
	             ParameterKey=AllowFlight,ParameterValue=TRUE \
	             ParameterKey=Mode,ParameterValue=creative \
	             ParameterKey=WorldZIPUrl,ParameterValue=https://example.com/file.zip \
	--capabilities CAPABILITY_IAM \
	--profile default \
	--region ap-southeast-2
```

## Local Run

```bash
docker run \
    --name minecraft \
    --volume minecraft:/data \
    --env EULA=TRUE \
    --publish 25565:25565 \
    itzg/minecraft-server
```

## References

```text
https://github.com/itzg/dockerfiles/tree/master/minecraft-server
https://forums.aws.amazon.com/thread.jspa?threadID=214736
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#cluster_reservation
https://aarongorka.com/blog/ecs-autoscaling-tips/
```
