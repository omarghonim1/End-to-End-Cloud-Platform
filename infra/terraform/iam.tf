resource "google_service_account" "gke_node_sa" {
  account_id   = "gke-node-sa"
  display_name = "GKE Node Service Account"
}

resource "google_project_iam_member" "gke_node_sa_role" {
  project = var.project_id
  role    = "roles/container.defaultNodeServiceAccount"
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}


resource "google_artifact_registry_repository_iam_member" "gke_node_artifact_reader" {
  project    = var.project_id
  location   = var.region
  repository = google_artifact_registry_repository.docker_repo.repository_id

  role   = "roles/artifactregistry.reader"
  member = "serviceAccount:${google_service_account.gke_node_sa.email}"
}