terraform {
  required_providers {
    kubernetes = {
      source  = "registry.opentofu.org/hashicorp/kubernetes"
      version = "2.23.0"
    }
    helm = {
      source  = "registry.opentofu.org/hashicorp/helm"
      version = "2.11.0"
    }
  }
}

# Правильная in-cluster конфигурация для Kubernetes
provider "kubernetes" {
  host                   = "https://kubernetes.default.svc:443"
  token                  = file("/var/run/secrets/kubernetes.io/serviceaccount/token")
  cluster_ca_certificate = file("/var/run/secrets/kubernetes.io/serviceaccount/ca.crt")
}

# Правильная in-cluster конфигурация для Helm
provider "helm" {
  kubernetes {
    host                   = "https://kubernetes.default.svc:443"
    token                  = file("/var/run/secrets/kubernetes.io/serviceaccount/token")
    cluster_ca_certificate = file("/var/run/secrets/kubernetes.io/serviceaccount/ca.crt")
  }
}