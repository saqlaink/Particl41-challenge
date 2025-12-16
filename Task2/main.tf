############################
# VPC
############################
resource "google_compute_network" "vpc" {
  name                    = "gke-vpc"
  auto_create_subnetworks = false
}

############################
# Public Subnets
############################
resource "google_compute_subnetwork" "public" {
  count         = 2
  name          = "public-subnet-${count.index}"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = cidrsubnet(var.network_cidr, 4, count.index)
}

############################
# Private Subnets
############################
resource "google_compute_subnetwork" "private" {
  count         = 2
  name          = "private-subnet-${count.index}"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = cidrsubnet(var.network_cidr, 4, count.index + 2)

  private_ip_google_access = true
}

############################
# GKE Cluster (Private)
############################
resource "google_container_cluster" "gke" {
  name     = "private-gke-cluster"
  location = var.region

  deletion_protection = false


  network    = google_compute_network.vpc.id
  subnetwork = google_compute_subnetwork.private[0].name

  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    disk_size_gb = 50
    disk_type    = "pd-standard"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {}
}

############################
# Node Pool (Private Only)
############################
resource "google_container_node_pool" "node_pool" {
  name       = "private-node-pool"
  cluster    = google_container_cluster.gke.name
  location   = var.region
  node_count = 2

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 50
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

############################
# Kubernetes Deployment
############################
resource "kubernetes_deployment" "app" {
  metadata {
    name = "web-app"
    labels = {
      app = "web"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "web"
      }
    }

    template {
      metadata {
        labels = {
          app = "web"
        }
      }

      spec {
        container {
          name  = "app"
          image = var.container_image

          port {
            container_port = var.app_port
          }
        }
      }
    }
  }
}

############################
# LoadBalancer Service
############################
resource "kubernetes_service" "lb" {
  metadata {
    name = "web-service"
  }

  spec {
    selector = {
      app = "web"
    }

    port {
      port        = 80
      target_port = var.app_port
    }

    type = "LoadBalancer"
  }
}
