output "project_id" {
  description = "GCP project ID created for the platform."
  value       = module.platform.project_id
}

output "service_account_email" {
  description = "Service account email used by the Kevin LOL service."
  value       = google_service_account.hcp_kevin_lol_service.email
}

output "workload_identity_pool_name" {
  description = "Name of the workload identity pool created for Terraform Cloud."
  value       = google_iam_workload_identity_pool.default.name
}

output "workload_identity_provider_name" {
  description = "Name of the workload identity pool provider created for Terraform Cloud."
  value       = google_iam_workload_identity_pool_provider.kevin_lol_service.name
}
