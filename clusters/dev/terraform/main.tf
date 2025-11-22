# Namespace для Velero
resource "kubernetes_namespace" "velero" {
  metadata {
    name = "velero"
  }
}

# Helm релиз Velero (использует предварительно созданный секрет)
resource "helm_release" "velero" {
  name       = "velero"
  repository = "https://vmware-tanzu.github.io/helm-charts"
  chart      = "velero"
  version    = "5.0.2"
  namespace  = kubernetes_namespace.velero.metadata[0].name

  set {
    name  = "configuration.provider"
    value = "aws"
  }

  set {
    name  = "configuration.backupStorageLocation.name"
    value = "default"
  }

  set {
    name  = "configuration.backupStorageLocation.bucket"
    value = var.velero_bucket_name
  }

  set {
    name  = "configuration.backupStorageLocation.config.region"
    value = "us-east-1"
  }

  set {
    name  = "configuration.backupStorageLocation.config.s3ForcePathStyle"
    value = "true"
  }

  set {
    name  = "configuration.backupStorageLocation.config.s3Url"
    value = var.minio_endpoint
  }

  set {
    name  = "credentials.existingSecret"
    value = "velero-credentials"
  }

  set {
    name  = "initContainers[0].name"
    value = "velero-plugin-for-aws"
  }

  set {
    name  = "initContainers[0].image"
    value = "velero/velero-plugin-for-aws:v1.8.0"
  }

  set {
    name  = "initContainers[0].volumeMounts[0].mountPath"
    value = "/target"
  }

  set {
    name  = "initContainers[0].volumeMounts[0].name"
    value = "plugins"
  }

  depends_on = [kubernetes_namespace.velero]
}