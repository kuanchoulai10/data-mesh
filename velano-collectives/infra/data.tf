data "google_organization" "main" {
  domain = "kcl10.com"
}

data "google_billing_account" "main" {
  display_name = "KCL"
}
