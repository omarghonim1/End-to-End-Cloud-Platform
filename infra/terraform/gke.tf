resource "google_container_cluster" "devops_gke" {
  name     = "devops-gke"
  location = var.region

  network    = google_compute_network.devops_vpc.id
  subnetwork = google_compute_subnetwork.gke_subnet.id

  remove_default_node_pool = true
  initial_node_count       = 1

  secret_manager_config {
    enabled = true
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods-range"
    services_secondary_range_name = "services-range"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  deletion_protection = false

  depends_on = [
    google_project_service.compute_api,
    google_project_service.container_api
  ]
}