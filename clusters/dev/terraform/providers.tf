terraform {
  required_providers {
    kubernetes = {
      source  = "terraform-registry-mirror.ru/hashicorp/kubernetes"
      version = "2.23.0"
    }
    helm = {
      source  = "terraform-registry-mirror.ru/hashicorp/helm"
      version = "2.11.0"
    }
  }
}

provider "kubernetes" {
  host                   = "https://kubernetes.default.svc:443"
  token                  = file("/var/run/secrets/kubernetes.io/serviceaccount/token")
  cluster_ca_certificate = file("/var/run/secrets/kubernetes.io/serviceaccount/ca.crt")
}

provider "helm" {
  kubernetes {
    host                   = "https://kubernetes.default.svc:443"
    token                  = file("/var/run/secrets/kubernetes.io/serviceaccount/token")
    cluster_ca_certificate = file("/var/run/secrets/kubernetes.io/serviceaccount/ca.crt")
  }
}