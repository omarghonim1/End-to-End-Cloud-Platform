resource "google_container_node_pool" "devops_nodes" {
  name           = "devops-node-pool"
  location       = var.region
  cluster        = google_container_cluster.devops_gke.name
  node_locations = ["me-central1-a"]

  node_count = 1

  node_config {
    machine_type    = "e2-medium"
    disk_size_gb    = 30
    disk_type       = "pd-balanced"
    image_type      = "COS_CONTAINERD"
    service_account = google_service_account.gke_node_sa.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}