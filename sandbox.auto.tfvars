org_id = "101420503993"

billing_account_id = "01078F-424E09-DB32B3"

environment = "sandbox"

app_identity_list = {
  "app-1" = {
    iam_roles                     = ["roles/iam.serviceAccountUser"]
    workload_identity_provider_id = "hcp-workload-identity-provider"
    hcp_project_id                = "hcp-project-1"
  }
}

deletion_policy = "DELETE"
