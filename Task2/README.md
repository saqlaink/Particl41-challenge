# GKE Terraform Infrastructure

This project deploys a **private GKE cluster** and runs a containerized web application,
exposed publicly using a **GCP LoadBalancer**.

---

## Prerequisites
- Terraform >= 1.5
- gcloud CLI
- Access to the GCP project

---

## Authenticate to GCP

```bash
gcloud auth login
gcloud auth application-default login
gcloud auth application-default set-quota-project gcp-terraform-481311
gcloud config set project gcp-terraform-481311
Enable Required APIs
bash
Copy code
gcloud services enable \
  container.googleapis.com \
  compute.googleapis.com \
  iam.googleapis.com \
  cloudresourcemanager.googleapis.com \
  serviceusage.googleapis.com \
  --project=gcp-terraform-481311
Deploy Infrastructure
bash
Copy code
terraform init
terraform plan
terraform apply
Access the Application
Terraform will output a public IP address:

bash
Copy code
curl http://<LOAD_BALANCER_IP>
Architecture Notes
GKE nodes run in private subnets only

No public IPs on worker nodes

Only the Load Balancer is public

No credentials are stored in this repository

Node disk size reduced to avoid regional SSD quota issues

Cleanup
bash
Copy code
terraform destroy