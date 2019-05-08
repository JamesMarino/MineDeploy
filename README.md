# Mine Deploy

CloudFormation Stack Minecraft Server Deployment on ECS

## Deployment

1. Package

```bash
aws cloudformation package \
    --template-file src/minedeploy.cloudformation.json \
    --s3-prefix minedeploy \
    --s3-bucket cloud-nested-templates \
    --output-template-file src/minedeploy.deploy.cloudformation.yaml \
    --profile default \
    --region ap-southeast-2
```

2. Validate

```bash
aws cloudformation validate-template \
    --template-body file://./src/minedeploy.deploy.cloudformation.yaml
```

3. Deploy

a) Create
```bash
aws cloudformation create-stack \
	--stack-name MineDeploy \
	--template-body file://./src/minedeploy.deploy.cloudformation.yaml \
	--parameters ParameterKey=HostName,ParameterValue=example.com \
	--capabilities CAPABILITY_IAM \
	--profile default \
	--region ap-southeast-2
```

b) Update
```bash
aws cloudformation update-stack \
	--stack-name MineDeploy \
	--template-body file://./src/minedeploy.deploy.cloudformation.yaml \
	--parameters ParameterKey=HostName,ParameterValue=example.com \
	--capabilities CAPABILITY_IAM \
	--profile default \
	--region ap-southeast-2
```
