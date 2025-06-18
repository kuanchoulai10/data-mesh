# --8<-- [start:aws]
resource "google_bigquery_connection" "aws" {
  connection_id = "aws"
  friendly_name = "aws"
  description   = "Created by Terraform"

  location = "aws-us-west-2"
  aws {
    access_role {
      # This must be constructed as a string instead of referencing the
      # AWS resources directly to avoid a resource dependency cycle
      # in Terraform.
      iam_role_id = "arn:aws:iam::545757050262:role/bigquery-role"
    }
  }
}
# --8<-- [end:aws]

# --8<-- [start:gcs]
resource "google_bigquery_connection" "gcs" {
  connection_id = "gcs"
  location      = "US"
  cloud_resource {}
}

module "bq_conn__gcs__project_iam" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 8.0"

  projects = [module.project.project_id]
  mode     = "additive"

  bindings = {
    "roles/storage.objectViewer" = [
      "serviceAccount:${google_bigquery_connection.gcs.cloud_resource[0].service_account_id}"
    ]
    "roles/serviceusage.serviceUsageConsumer" = [
      "serviceAccount:${google_bigquery_connection.gcs.cloud_resource[0].service_account_id}"
    ]
    "roles/documentai.viewer" = [
      "serviceAccount:${google_bigquery_connection.gcs.cloud_resource[0].service_account_id}"
    ]
  }
}
# --8<-- [end:gcs]

# --8<-- [start:cloud-vision]
resource "google_bigquery_connection" "cloud_vision" {
  connection_id = "cloud-vision"
  location      = "US"
  cloud_resource {}
}
# --8<-- [end:cloud-vision]

# --8<-- [start:doc-ai]
resource "google_bigquery_connection" "doc_ai" {
  connection_id = "doc-ai"
  location      = "US"
  cloud_resource {}
}

module "bq_conn__doc_ai__project_iam" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 8.0"

  projects = [module.project.project_id]
  mode     = "additive"

  bindings = {
    "roles/documentai.viewer" = [
      "serviceAccount:${google_bigquery_connection.doc_ai.cloud_resource[0].service_account_id}"
    ]
  }
}
# --8<-- [end:doc-ai]

# --8<-- [start:vertex-ai]
resource "google_bigquery_connection" "vertex_ai" {
  connection_id = "vertex-ai"
  location      = "US"
  cloud_resource {}
}

module "bq_conn__vertex_ai__project_iam" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 8.0"

  projects = [module.project.project_id]
  mode     = "additive"

  bindings = {
    "roles/aiplatform.user" = [
      "serviceAccount:${google_bigquery_connection.vertex_ai.cloud_resource[0].service_account_id}"
    ]
  }
}
# --8<-- [end:vertex-ai]

# --8<-- [start:remote-funcs]
resource "google_bigquery_connection" "remove_html_tags" {
  connection_id = "remove-html-tags"
  location      = "US"
  cloud_resource {}
}

module "bq_conn__remote_funcs__project_iam" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 8.0"

  projects = [module.project.project_id]
  mode     = "additive"

  bindings = {
    "roles/run.invoker" = [
      "serviceAccount:${google_bigquery_connection.remove_html_tags.cloud_resource[0].service_account_id}"
    ]
  }
}
# --8<-- [end:remote-funcs]
