resource "google_compute_network" "vpc" {
  name                    = "gke-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  count         = 2
  name          = "public-subnet-${count.index}"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = cidrsubnet("10.0.0.0/16", 4, count.index)
}

resource "google_compute_subnetwork" "private" {
  count         = 2
  name          = "private-subnet-${count.index}"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = cidrsubnet("10.0.0.0/16", 4, count.index + 2)

  private_ip_google_access = true
}
