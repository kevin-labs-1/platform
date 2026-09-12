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

module "kevin_lol_service" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.3"

  folder_id       = google_folder.default.id
  name            = "kevin-lol-service"
  billing_account = var.billing_account_id
  activate_apis = [
    "compute.googleapis.com",
    "cloudsql.googleapis.com",
    "secretmanager.googleapis.com",
    "cloudrun.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
  ]
  deletion_policy = "DELETE"
}
