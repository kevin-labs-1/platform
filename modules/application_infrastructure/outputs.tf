output "staging_project_id" {
  value = module.staging_project.project_id
}

output "production_project_id" {
  value = module.production_project.project_id
}

output "workload_identity_provider_id" {
  value       = google_iam_workload_identity_pool_provider.default.id
  description = "The ID of the created workload identity provider"
}

output "service_account_email" {
  value       = google_service_account.default.email
  description = "The email of the created service account"
}
