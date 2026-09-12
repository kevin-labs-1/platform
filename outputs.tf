output "application_infrastructure" {
  value       = [for k, sa in module.application_infrastructure : sa]
  description = "List of created application platforms."
}
