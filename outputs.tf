output "project_id" {
  description = "ID of the created project."
  value       = module.platform.project_id
}

output "workload_identity_pool_id" {
  description = "ID of the created workload identity pool for HCP."
  value       = google_iam_workload_identity_pool.default.workload_identity_pool_id
}

output "workload_identity_pool_name" {
  description = "Name of the created workload identity pool for HCP."
  value       = google_iam_workload_identity_pool.default.name
}

output "application_platform_list" {
  description = "List of created application platforms."
  value       = [for k, sa in module.app_identity : sa]
}
