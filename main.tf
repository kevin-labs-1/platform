terraform {
  required_version = "~> 1.16.0"

  cloud {
    organization = "kevin-labs"
    workspaces {}
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.23.0, < 8.0.0"
    }
  }
}

locals {
  project_name = "platform-${var.environment}"

  hcp_organization = "kevin-labs"

  required_apis = [
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "sts.googleapis.com",
  ]
}

module "platform" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.3"

  org_id            = var.org_id
  name              = local.project_name
  random_project_id = true
  billing_account   = var.billing_account_id
  activate_apis     = local.required_apis
  deletion_policy   = var.deletion_policy
}

resource "google_iam_workload_identity_pool" "default" {
  project                   = module.platform.project_id
  workload_identity_pool_id = "hcp-identity-pool"
  display_name              = "HCP Identity Pool"
  description               = "Allows HCP to exchange OIDC tokens for Google Cloud access."
}

module "app_identity" {
  source = "./modules/app-identity"

  for_each = var.app_identity_list

  org_id                             = var.org_id
  billing_account_id                 = var.billing_account_id
  project                            = module.platform.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.default.workload_identity_pool_id
  workload_identity_pool_provider_id = each.value.hcp_project_id
  iam_roles                          = each.value.iam_roles

  hcp_organization_id = local.hcp_organization
  hcp_project_id      = each.value.hcp_project_id
}
