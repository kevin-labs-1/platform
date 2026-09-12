variable "parent" {
  type        = string
  description = "The location where permissions are granted"
}

variable "billing_account_id" {
  type        = string
  description = "The billing account ID that can be linked to projects"
}

variable "application_name" {
  type        = string
  description = "The name of the application"
}

variable "required_apis" {
  type        = list(string)
  description = "The list of APIs to enable in the created projects"
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
