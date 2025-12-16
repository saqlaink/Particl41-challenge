resource "kubernetes_deployment" "app" {
  metadata {
    name = "web-app"
    labels = { app = "web" }
  }

  spec {
    replicas = 2

    selector {
      match_labels = { app = "web" }
    }

    template {
      metadata {
        labels = { app = "web" }
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

resource "kubernetes_service" "lb" {
  metadata {
    name = "web-service"
  }

  spec {
    selector = { app = "web" }

    port {
      port        = 80
      target_port = var.app_port
    }

    type = "LoadBalancer"
  }
}
