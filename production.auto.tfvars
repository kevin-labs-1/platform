org_id = "101420503993"

billing_account_id = "01078F-424E09-DB32B3"

environment = "production"

app_identity_list = {
  "kevin_lol_service" = {
    workload_identity_provider_id = "kevin-lol-service"
    hcp_project_id                = "kevin-lol-service"
    iam_roles = [
      "roles/cloudsql.admin"
    ]
  }
  "kevin_web_app" = {
    workload_identity_provider_id = "kevin-lol-service"
    hcp_project_id                = "kevin-web-app"
    iam_roles = [
      "roles/cloudsql.admin"
    ]
  }
}

deletion_policy = "PREVENT"
