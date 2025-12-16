resource "google_container_cluster" "gke" {
  name     = "private-gke-cluster"
  location = var.region

  deletion_protection = false

  network    = var.network_id
  subnetwork = var.subnet_id

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

resource "google_container_node_pool" "nodes" {
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
