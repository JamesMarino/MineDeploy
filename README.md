# Mine Deploy

Terraform Deployment of MineCraft to AWS ECS

Running

1. Edit `production.tfvars`
2. Edit `workspace.tf`
3. Run the following

```bash
terraform plan -out plan.tfstate -var-file=production.tfvars
terraform apply plan.tfstate
```
