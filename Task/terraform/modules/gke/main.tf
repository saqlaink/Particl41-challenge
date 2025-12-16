resource "google_container_cluster" "cluster" {
  name     = "${var.app_name}-cluster"
  location = var.region

  network    = var.network
  subnetwork = var.subnetwork

  remove_default_node_pool = true
  initial_node_count       = 1

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {}
}

resource "google_container_node_pool" "nodes" {
  name     = "private-pool"
  location = var.region
  cluster  = google_container_cluster.cluster.name

  node_count = 2

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
