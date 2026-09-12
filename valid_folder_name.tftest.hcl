variables {
  org_id = "101420503993"

  billing_account_id = "01078F-424E09-DB32B3"

  application_infrastructure = {
    kevin_lol_service = {
      application_name = "kevin-lol-service"
      required_apis = [
        "cloudsql.googleapis.com"
      ]
      iam_roles = [
        "roles/cloudsql.admin"
      ]
      hcp_organization_id = "kevin"
      hcp_project_id      = "kevin-lol-service"
    }
  }
}

run "valid_folder_name" {
  assert {
    condition     = module.application_infrastructure.service_account_email == "12"
    error_message = "folder has the wrong name"
  }
}
