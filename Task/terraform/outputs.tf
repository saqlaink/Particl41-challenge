output "load_balancer_ip" {
  description = "Public IP of the application"
  value       = module.gke.ingress_ip
}
