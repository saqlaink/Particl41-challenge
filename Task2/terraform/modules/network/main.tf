resource "google_compute_network" "vpc" {
  name                    = "simple-time-service-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public_1" {
  name          = "public-subnet-1"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.0.1.0/24"
}

resource "google_compute_subnetwork" "public_2" {
  name          = "public-subnet-2"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.0.2.0/24"
}

resource "google_compute_subnetwork" "private_1" {
  name          = "private-subnet-1"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.0.101.0/24"
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "private_2" {
  name          = "private-subnet-2"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.0.102.0/24"
  private_ip_google_access = true
}
