variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "network_cidr" {
  description = "VPC CIDR range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "container_image" {
  description = "Docker image to deploy"
  type        = string
}

variable "app_port" {
  description = "Container port exposed by the app"
  type        = number
  default     = 80
}
