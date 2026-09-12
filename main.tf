terraform {
  required_version = "~> 1.16.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.23.0, < 8.0.0"
    }
  }
}

module "application_infrastructure" {
  source = "./modules/application_infrastructure"

  for_each = var.application_infrastructure

  organization_id    = var.org_id
  billing_account_id = var.billing_account_id

  application_name = each.value.application_name
  required_apis    = each.value.required_apis
  iam_roles        = each.value.iam_roles

  hcp_organization_id = each.value.hcp_organization_id
  hcp_project_id      = each.value.hcp_project_id
}
