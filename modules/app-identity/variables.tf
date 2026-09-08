variable "org_id" {
  type        = string
  description = "The Google Cloud organization ID where project creation permissions are granted"
}

variable "project" {
  type        = string
  description = "The ID of the GCP project to create all resources"
}

variable "billing_account_id" {
  type        = string
  description = "The billing account ID that can be linked to projects"
}

variable "workload_identity_pool_id" {
  type        = string
  description = "The ID of an existing workload identity pool"
}

variable "workload_identity_pool_provider_id" {
  type        = string
  description = "The ID of the created workload identity provider for the given pool."
}

variable "iam_roles" {
  type        = list(string)
  description = "The IAM roles to assign to the created service account"
}

variable "hcp_organization_id" {
  type        = string
  description = "The ID of the HCP organization"
}

variable "hcp_project_id" {
  type        = string
  description = "The ID of the HCP project"
}
