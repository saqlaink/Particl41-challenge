output "load_balancer_ip" {
  value = kubernetes_service.lb.status[0].load_balancer[0].ingress[0].ip
}
