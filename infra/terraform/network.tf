resource "google_compute_network" "devops_vpc" {
  name                    = "devops-vpc"
  auto_create_subnetworks = false

  depends_on = [
    google_project_service.compute_api ## Mandatory
  ]

}

resource "google_compute_subnetwork" "gke_subnet" {
  name          = "gke-subnet"
  ip_cidr_range = "10.10.0.0/20"
  region        = var.region
  network       = google_compute_network.devops_vpc.id

  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = "10.20.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.30.0.0/20"
  }

  depends_on = [
    google_project_service.compute_api
  ]
}
