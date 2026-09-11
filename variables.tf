variable "org_id" {
  type        = string
  description = "The organization ID."
}

variable "billing_account_id" {
  type        = string
  description = "Billing account ID used to create the project."
}

variable "environment" {
  type    = string
  default = "sandbox"
}

variable "app_identity_list" {
  type = map(object({
    hcp_project_id = string
    iam_roles      = list(string)
  }))
}

variable "deletion_policy" {
  type        = string
  description = "Whether to allow deletion of all provisioned resources. Can be 'PREVENT' or 'DELETE'."
  default     = "PREVENT"
}
