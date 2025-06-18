
module "project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 17.1"

  name              = "velano-collective"
  random_project_id = true
  org_id            = data.google_organization.main.org_id
  billing_account   = data.google_billing_account.main.id
  sa_role           = "roles/editor"
  activate_apis = [
    "bigquery.googleapis.com",
    "bigqueryconnection.googleapis.com",
    "run.googleapis.com",
    "cloudfunctions.googleapis.com",
    "compute.googleapis.com",
    "cloudbuild.googleapis.com",
    "vision.googleapis.com",
    "documentai.googleapis.com",
    "aiplatform.googleapis.com",
    "datacatalog.googleapis.com",
    "dataplex.googleapis.com"
    # "cloudresourcemanager.googleapis.com", # optional
    # "serviceusage.googleapis.com",         # optional
  ]
}