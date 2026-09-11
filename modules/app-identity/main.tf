resource "google_iam_workload_identity_pool_provider" "default" {
  project                            = var.project
  workload_identity_pool_id          = var.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id

  attribute_mapping = {
    "google.subject" = "assertion.sub"
  }

  attribute_condition = "assertion.aud == \"https://app.terraform.io\" && assertion.terraform_organization_id == \"${var.hcp_organization_id}\" && assertion.terraform_project_id == \"${var.hcp_project_id}\""

  oidc {
    issuer_uri = "https://app.terraform.io"
  }
}

resource "google_service_account" "default" {
  project    = var.project
  account_id = var.hcp_project_id
}

resource "google_project_iam_member" "sa_roles" {
  for_each = toset(var.iam_roles)

  project = var.project
  role    = each.value
  member  = google_service_account.default.member
}

resource "google_organization_iam_member" "project_creator" {
  org_id = var.org_id
  role   = "roles/resourcemanager.projectCreator"
  member = google_service_account.default.member
}

resource "google_billing_account_iam_member" "billing_user" {
  billing_account_id = var.billing_account_id
  role               = "roles/billing.user"
  member             = google_service_account.default.member
}
