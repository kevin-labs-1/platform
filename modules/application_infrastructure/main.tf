resource "google_folder" "default" {
  display_name = var.application_name
  parent       = "organizations/${var.organization_id}"
}

module "staging_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.3"

  org_id            = var.organization_id
  name              = "${var.application_name}-staging"
  billing_account   = var.billing_account_id
  activate_apis     = var.required_apis
  deletion_policy   = "PREVENT"
}

module "production_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.3"

  org_id            = var.organization_id
  name              = "${var.application_name}-production"
  billing_account   = var.billing_account_id
  activate_apis     = var.required_apis
  deletion_policy   = "PREVENT"
}

module "workload_identity_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.3"

  org_id            = var.organization_id
  name              = "${var.application_name}-workload"
  billing_account   = var.billing_account_id
  activate_apis     = ["iam.googleapis.com"]
  deletion_policy   = "PREVENT"
}

resource "google_iam_workload_identity_pool" "default" {
  project                   = module.workload_identity_project.project_id
  workload_identity_pool_id = "${var.application_name}-hcp-project"
}

resource "google_iam_workload_identity_pool_provider" "default" {
  project                            = module.workload_identity_project.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.default.workload_identity_pool_id
  workload_identity_pool_provider_id = "${var.application_name}-provider"

  oidc {
    issuer_uri = "https://app.terraform.io"
  }

  attribute_mapping = {
    "google.subject" = "assertion.sub"
  }

  attribute_condition = "assertion.aud == \"https://app.terraform.io\" && assertion.terraform_organization_id == \"${var.hcp_organization_id}\" && assertion.terraform_project_id == \"${var.hcp_project_id}\""
}

resource "google_service_account" "default" {
  project    = module.workload_identity_project.project_id
  account_id = "some-account"
}

resource "google_project_iam_member" "default" {
  for_each = toset(var.iam_roles)

  project = module.workload_identity_project.project_id
  role    = each.value
  member  = google_service_account.default.member
}
