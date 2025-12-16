# SimpleTimeService – GCP (Terraform + GKE)

This repository provisions GCP infrastructure using Terraform and deploys
the SimpleTimeService container on Google Kubernetes Engine.

## Prerequisites
- Terraform >= 1.5
- gcloud CLI
- kubectl

## Authentication
```bash
gcloud auth application-default login
Deploy
bash
Copy code
cd terraform
terraform init
terraform apply -var-file=envs/dev/terraform.tfvars
Access
bash
Copy code
kubectl get ingress -n simple-time-service
curl http://<LB-IP>/
Notes
GKE nodes run in private subnets

Public access via GCP Load Balancer

No credentials committed