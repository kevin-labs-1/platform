terraform {
  required_version = "~> 1.16.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.23.0, < 8.0.0"
    }
  }
}

resource "google_folder" "default" {
  display_name        = "platform-${var.environment}"
  parent              = "organizations/${var.org_id}"
  deletion_protection = false
}

module "application_platform" {
  source = "modules/application_platform"

  for_each = var.application_infrastructure

  parent             = google_folder.default.id
  billing_account_id = var.billing_account_id

  application_name = each.value.application_name
  required_apis    = each.value.required_apis
  iam_roles        = each.value.iam_roles

  hcp_organization_id = each.value.hcp_organization_id
  hcp_project_id      = each.value.hcp_project_id
}
