# End-to-End GCP Cloud Platform

Production-style cloud-native platform built on **Google Cloud (GCP)** using **GKE, Terraform, Docker, GitHub Actions, and Argo CD**.

## Architecture

User
 ↓
GCP Load Balancer
 ↓
Gateway API
 ↓
HTTPRoute
 ├── Frontend → Nginx
 └── /api     → Backend → Node.js
                         ↓
                  Google Secret Manager

Git Push
 ↓
GitHub Actions
 ↓
Docker Build
 ↓
Trivy Scan
 ↓
Artifact Registry
 ↓
Update Kubernetes Image Tag
 ↓
Argo CD
 ↓
GKE

Prometheus → Metrics
Grafana    → CPU / Memory
HPA        → Auto Scaling

Tech Stack
- Cloud: GCP / GKE
- IaC: Terraform
- Containers: Docker
- CI: GitHub Actions
- GitOps: Argo CD
- Registry: Artifact Registry
- Security: Trivy, Workload Identity, Secret Manager, NetworkPolicy, Pod Security
- Monitoring: Prometheus + Grafana
- Scaling: Kubernetes HPA
- Routing: Gateway API + HTTPRoute


.
├── app/
│   ├── backend/
│   └── frontend/
│
├── infra/
│   ├── terraform/
│   ├── k8s/
│   └── argocd/
│
├── scripts/
│   └── test-hpa.sh
│
└── .github/
    └── workflows/
        └── ci.yml

Build → Trivy Scan → Push to Artifact Registry
      → Update Image Tag in Git
      → Argo CD Sync
      → GKE Deployment

Authentication between GitHub Actions and GCP uses OIDC + Workload Identity Federation, so no long-lived JSON service-account key is required.

Security
- Containers run as non-root
- Linux capabilities dropped
- Privilege escalation disabled
- Read-only container filesystem where applicable
- Kubernetes NetworkPolicy
- Kubernetes Pod Security
- Secrets stored in Google Secret Manager
- Workload Identity instead of static credentials
- Trivy vulnerability scanning in CI
Monitoring & Autoscaling
Prometheus collects Kubernetes metrics and Grafana displays:
- Pod CPU
- Pod Memory
The Backend uses HPA:

1 → 3 replicas

Deployment

Infrastructure:

cd infra/terraform
terraform init
terraform apply

HPA Test

./scripts/test-hpa.sh

The script generates traffic to the Backend and allows you to observe:
CPU ↑
 ↓
HPA
 ↓
Pods scale up
 ↓
Grafana shows the change live


Goal
This project demonstrates an end-to-end GCP DevOps workflow covering:
Infrastructure → Containers → CI → Security Scan → Registry → GitOps → Kubernetes → Secrets → Autoscaling → Monitoring