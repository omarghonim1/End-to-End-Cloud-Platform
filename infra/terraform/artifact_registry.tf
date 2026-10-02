resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.region
  repository_id = "devops-repo"
  description   = "Docker images for DevOps GKE project"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }

  depends_on = [
    google_project_service.artifact_registry_api
  ]
}