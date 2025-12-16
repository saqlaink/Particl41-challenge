module "network" {
  source     = "./modules/network"
  project_id = var.project_id
  region     = var.region
}

module "gke" {
  source        = "./modules/gke"
  project_id    = var.project_id
  region        = var.region
  network_id    = module.network.vpc_id
  subnetwork_id = module.network.private_subnet_1_id
}

module "k8s_app" {
  source = "./modules/k8s-app"

  cluster_endpoint = module.gke.endpoint
  cluster_ca_cert  = module.gke.ca_certificate
}
