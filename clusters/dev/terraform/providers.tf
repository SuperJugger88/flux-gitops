terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.11.0"
    }
  }
  required_version = ">= 0.13"
  backend "kubernetes" {
    secret_suffix = "velero-state"
    namespace     = "flux-system"
    in_cluster_config = true
  }
}

provider "kubernetes" {
  host                   = "https://kubernetes.default.svc:443"
  token                  = file("/var/run/secrets/kubernetes.io/serviceaccount/token")
  cluster_ca_certificate = file("/var/run/secrets/kubernetes.io/serviceaccount/ca.crt")

  exec {
    api_version = "client.authentication.k8s.io/v1"
    command     = "sh"
    args = ["-c", "cat /var/run/secrets/kubernetes.io/serviceaccount/token"]
  }
}

provider "helm" {
  kubernetes {
    host                   = "https://kubernetes.default.svc:443"
    token                  = file("/var/run/secrets/kubernetes.io/serviceaccount/token")
    cluster_ca_certificate = file("/var/run/secrets/kubernetes.io/serviceaccount/ca.crt")
  }
  debug = true
}

provider "yandex" {
  zone = "ru-central-1"
}