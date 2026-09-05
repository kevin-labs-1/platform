variable "gcp_project_name" {
  description = "Base name applied to the GCP project created by the project factory module."
  type        = string
  default     = "kevin-lol-platform"
}

variable "gcp_billing_account_id" {
  description = "Billing account ID used to create the project."
  type        = string
}

variable "wif_pool_id" {
  description = "Workload identity pool ID used by Terraform Cloud."
  type        = string

  validation {
    condition     = can(regex("^[a-z]([a-z0-9-]{0,61}[a-z0-9])?$", var.wif_pool_id))
    error_message = "The WIF pool ID must be 1-63 characters, start with a letter, and contain only lowercase letters, numbers, and dashes."
  }
}

variable "hcp_organization_id" {
  description = "Terraform Cloud organization ID that is allowed to authenticate to the workload identity pool."
  type        = string
}

variable "hcp_project_id" {
  description = "Terraform Cloud project ID that is allowed to authenticate to the workload identity pool."
  type        = string
  default     = "kevin-lol-service"
}

variable "service_account_id" {
  description = "Google Cloud service account ID to create for the Kevin LOL service."
  type        = string
  default     = "kevin-lol-service"
}

variable "workload_identity_provider_id" {
  description = "Workload identity pool provider ID used for Terraform Cloud OIDC federation."
  type        = string
  default     = "kevin-lol-service"
}
