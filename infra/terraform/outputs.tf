output "vpc_name" {
  value = google_compute_network.devops_vpc.name
}

output "subnet_name" {
  value = google_compute_subnetwork.gke_subnet.name
}

output "gke_cluster_name" {
  value = google_container_cluster.devops_gke.name
}

output "gke_cluster_endpoint" {
  value = google_container_cluster.devops_gke.endpoint
}

output "node_service_account" {
  value = google_service_account.gke_node_sa.email
}