# GKE Terraform – Private Kubernetes Cluster Deployment

This repository provisions a **private GKE cluster** on Google Cloud Platform using Terraform
and deploys a containerized web application exposed via a **public LoadBalancer**.

The setup follows Terraform best practices:
- Modular folder structure
- Private worker nodes
- No credentials committed to the repository
- One-command deployment (`terraform plan` / `terraform apply`)

---

## 📁 Repository Structure

```text
.
├── modules/
│   ├── network/     # VPC and subnets
│   ├── gke/         # GKE cluster and node pool
│   └── app/         # Kubernetes deployment and service
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
└── README.md
````

---

## 🔧 Prerequisites

* Terraform >= 1.5
* Google Cloud SDK (`gcloud`)
* Access to a GCP project

---

## 🔐 Authenticate to GCP

Terraform uses **Application Default Credentials (ADC)**.

Run the following commands:

```bash
gcloud auth login
gcloud auth application-default login
gcloud auth application-default set-quota-project <YOUR_PROJECT_ID>
gcloud config set project <YOUR_PROJECT_ID>
```

---

## 🔌 Enable Required GCP APIs

```bash
gcloud services enable \
  container.googleapis.com \
  compute.googleapis.com \
  iam.googleapis.com \
  cloudresourcemanager.googleapis.com \
  serviceusage.googleapis.com \
  --project <YOUR_PROJECT_ID>
```

---

## 📝 Configure Terraform Variables

Copy the example file and update values:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` and replace the project ID:

```hcl
project_id      = "your-gcp-project-id"
container_image = "nginx:alpine"
app_port        = 80
```

---

## 🚀 Deploy Infrastructure

From the project root:

```bash
terraform init
terraform plan
terraform apply
```

Confirm with `yes` when prompted.

---

## 🌐 Access the Application

After deployment, Terraform will output a public IP address:

```bash
curl http://<LOAD_BALANCER_IP>
```

You should receive the application response.

---

## 🧹 Cleanup

To destroy all resources:

```bash
terraform destroy
```

