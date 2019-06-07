# Platform

Notes:

* When updating the CloudFormation stack set desired instances to 2 in AutoScaling due
  to Reserved CPU and Memory allocation at it's maximum.

## Deployment

For the following `cd platform`

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
	--stack-name Example-Minecraft \
	--template-body file://./src/minedeploy.deploy.cloudformation.yaml \
	--parameters ParameterKey=HostName,ParameterValue=example.com \
                 ParameterKey=EnvironmentName,ParameterValue=test \
	             ParameterKey=AvailabilityZone,ParameterValue=ap-southeast-2a \
	             ParameterKey=MineDeployVolumeName,ParameterValue=ExampleMinecraftVolume \
	             ParameterKey=HostedZoneId,ParameterValue=Z2W447I3OZ6EAE \
	             ParameterKey=MineDeployLoadBalancerName,ParameterValue=example-loadbalancer \
	             ParameterKey=KeyName,ParameterValue=ExampleKey \
	             ParameterKey=ServerName,ParameterValue="Example Name" \
	             ParameterKey=Difficulty,ParameterValue=normal \
	             ParameterKey=AllowNether,ParameterValue=TRUE \
	             ParameterKey=GenerateStructures,ParameterValue=TRUE \
	             ParameterKey=SpawnAnimals,ParameterValue=TRUE \
	             ParameterKey=SpawnNPCs,ParameterValue=TRUE \
	             ParameterKey=MessageOfTheDay,ParameterValue="Server Message of the Day" \
	             ParameterKey=AllowFlight,ParameterValue=TRUE \
	             ParameterKey=EnableCommandBlocks,ParameterValue=TRUE \
	             ParameterKey=Mode,ParameterValue=survival \
	             ParameterKey=AdminPlayers,ParameterValue=ExampleUser \
	             ParameterKey=WorldZIPUrl,ParameterValue= \
	--capabilities CAPABILITY_IAM \
	--profile default \
	--region ap-southeast-2
```

b) Update

**Warning: Package Before Updating**

```bash
aws cloudformation update-stack \
	--stack-name Example-Minecraft \
	--template-body file://./src/minedeploy.deploy.cloudformation.yaml \
	--parameters ParameterKey=HostName,ParameterValue=example.com \
                 ParameterKey=EnvironmentName,ParameterValue=test \
	             ParameterKey=AvailabilityZone,ParameterValue=ap-southeast-2a \
	             ParameterKey=MineDeployVolumeName,ParameterValue=ExampleMinecraftVolume \
	             ParameterKey=HostedZoneId,ParameterValue=Z2W447I3OZ6EAE \
	             ParameterKey=MineDeployLoadBalancerName,ParameterValue=example-loadbalancer \
	             ParameterKey=KeyName,ParameterValue=ExampleKey \
	             ParameterKey=ServerName,ParameterValue="Example Name" \
	             ParameterKey=Difficulty,ParameterValue=normal \
	             ParameterKey=AllowNether,ParameterValue=TRUE \
	             ParameterKey=GenerateStructures,ParameterValue=TRUE \
	             ParameterKey=SpawnAnimals,ParameterValue=TRUE \
	             ParameterKey=SpawnNPCs,ParameterValue=TRUE \
	             ParameterKey=MessageOfTheDay,ParameterValue="Server Message of the Day" \
	             ParameterKey=AllowFlight,ParameterValue=TRUE \
	             ParameterKey=EnableCommandBlocks,ParameterValue=TRUE \
	             ParameterKey=Mode,ParameterValue=survival \
	             ParameterKey=AdminPlayers,ParameterValue=ExampleUser \
	             ParameterKey=WorldZIPUrl,ParameterValue= \
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
