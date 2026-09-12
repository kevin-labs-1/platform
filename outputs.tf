output "application_infrastructure" {
  value       = [for k, sa in module.application_platform : sa]
  description = "List of created application platforms."
}
