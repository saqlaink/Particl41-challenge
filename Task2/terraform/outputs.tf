output "cluster_name" {
  value = module.gke.cluster_name
}

data "google_project" "current" {
  project_id = var.project_id
}