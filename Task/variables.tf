variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  default     = "us-central1"
}

variable "container_image" {
  type        = string
}

variable "app_port" {
  type        = number
  default     = 80
}
