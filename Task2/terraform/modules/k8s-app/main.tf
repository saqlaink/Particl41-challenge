provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_ca_cert)
  token                  = data.google_client_config.default.access_token
}

data "google_client_config" "default" {}

resource "kubernetes_namespace" "app" {
  metadata {
    name = "simple-time-service"
  }
}

resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(file("${path.root}/../kubernetes/base/deployment.yaml"))
}

resource "kubernetes_manifest" "service" {
  manifest = yamldecode(file("${path.root}/../kubernetes/base/service.yaml"))
}

resource "kubernetes_manifest" "ingress" {
  manifest = yamldecode(file("${path.root}/../kubernetes/base/ingress.yaml"))
}
