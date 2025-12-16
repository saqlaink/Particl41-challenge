provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source  = "./modules/network"
  project_id = var.project_id
  region     = var.region
}

module "gke" {
  source       = "./modules/gke"
  project_id   = var.project_id
  region       = var.region
  network      = module.network.network_name
  subnetwork   = module.network.private_subnet
  app_name     = var.app_name
  container_image = var.container_image
}
