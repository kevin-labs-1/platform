terraform {
  required_version = "~> 1.16.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.23.0, < 8.0.0"
    }
  }
}

locals {
  required_apis = [
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "sts.googleapis.com",
    "sqladmin.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
    "artifactregistry.googleapis.com",
  ]
}

module "platform" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.3"

  name              = var.gcp_project_name
  random_project_id = true
  billing_account   = var.gcp_billing_account_id
}

resource "google_project_service" "required_apis" {
  for_each = toset(local.required_apis)

  project = module.platform.project_id
  service = each.value

  disable_on_destroy = false
}

resource "google_iam_workload_identity_pool" "default" {
  project                   = module.platform.project_id
  workload_identity_pool_id = var.wif_pool_id
  display_name              = "Terraform Cloud Identity Pool"
  description               = "Allows Terraform Cloud to exchange OIDC tokens for Google Cloud access."

  depends_on = [google_project_service.required_apis]
}

resource "google_iam_workload_identity_pool_provider" "kevin_lol_service" {
  project                            = module.platform.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.default.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_provider_id

  attribute_mapping = {
    "google.subject" = "assertion.sub"
  }

  attribute_condition = "assertion.aud == \"https://app.terraform.io\" && assertion.terraform_organization_id == \"${var.hcp_organization_id}\" && assertion.terraform_project_id == \"${var.hcp_project_id}\""

  oidc {
    issuer_uri = "https://app.terraform.io"
  }
}

resource "google_service_account" "hcp_kevin_lol_service" {
  project      = module.platform.project_id
  account_id   = var.service_account_id
  display_name = "Kevin LOL Service"
  description  = "Service account used by the Kevin LOL service."

  depends_on = [google_project_service.required_apis]
}

module "kevin_lol_service_iam" {
  source  = "terraform-google-modules/iam/google//modules/service_accounts_iam"
  version = "~> 8.0"

  service_accounts = [google_service_account.hcp_kevin_lol_service.email]
  project          = module.platform.project_id
  mode             = "authoritative"

  bindings = {
    "roles/cloudsql.admin" = [
      "serviceAccount:${google_service_account.hcp_kevin_lol_service.email}",
    ]

    "roles/cloudrun.admin" = [
      "serviceAccount:${google_service_account.hcp_kevin_lol_service.email}",
    ]

    "roles/secretmanager.admin" = [
      "serviceAccount:${google_service_account.hcp_kevin_lol_service.email}",
    ]

    "roles/artifactregistry.admin" = [
      "serviceAccount:${google_service_account.hcp_kevin_lol_service.email}",
    ]
  }
}
