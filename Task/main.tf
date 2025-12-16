module "network" {
  source       = "./modules/network"
  project_id   = var.project_id
  region       = var.region
}

module "gke" {
  source     = "./modules/gke"
  project_id = var.project_id
  region     = var.region

  network_id    = module.network.vpc_id
  subnet_id     = module.network.private_subnet_ids[0]
}

module "app" {
  source          = "./modules/app"
  container_image = var.container_image
  app_port        = var.app_port
}
