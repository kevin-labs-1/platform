variable "org_id" {
  type        = string
  description = "The organization ID."
}

variable "billing_account_id" {
  type        = string
  description = "Billing account ID used to create the project."
}

variable "environment" {
  type        = string
  description = "The environment to deploy to."
}
