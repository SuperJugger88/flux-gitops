terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.11.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
  host = "https://127.0.0.1:6443"
  insecure = true
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "docker-desktop"
    host           = "https://127.0.0.1:6443"
    insecure = true
  }
}