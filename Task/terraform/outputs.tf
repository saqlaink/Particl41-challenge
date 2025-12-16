output "load_balancer_ip" {
  description = "Public IP of the application"
  value       = kubernetes_ingress_v1.app.status[0].load_balancer[0].ingress[0].ip
}
