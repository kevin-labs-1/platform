variable "org_id" {
  type        = string
  description = "The organization ID."
}

variable "billing_account_id" {
  type        = string
  description = "Billing account ID used to create the project."
}

variable "application_infrastructure" {
  type = map(object({
    application_name    = string
    required_apis       = list(string)
    iam_roles           = list(string)
    hcp_organization_id = string
    hcp_project_id      = string
  }))
}
