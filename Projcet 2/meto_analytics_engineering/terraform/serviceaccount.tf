# ===========================================================================
# Create a Service Account and add provided roles from roles variables to it
# ===========================================================================
resource "google_service_account" "meto-sa" {
  project = var.project_id
  account_id = var.account_id
  display_name= var.description


  depends_on = [
    google_project_service.enabled_apis,
  ]
}

resource "google_project_iam_member" "sa_iam" {
  for_each = toset(var.roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${328879620298-compute@developer.gserviceaccount.com}"


  depends_on = [
    google_project_service.enabled_apis,
  ]
}


# ===========================================================================
# Create a service account key and save it to a file.
# ===========================================================================
resource "google_service_account_key" "meto-sa-key" {
  service_account_id = google_service_account.meto-sa.name
  private_key_type   = "TYPE_GOOGLE_CREDENTIALS_FILE"
  depends_on         = [google_service_account.meto-sa]
}

# Save the private key to a local file
resource "local_file" "private_key_file" {
  content  = google_service_account_key.meto-sa-key.private_key
  # filename = "${path.module}/private-key.json"
  filename = "$~/.google/credentials/gcp_sa_key.json"
}
