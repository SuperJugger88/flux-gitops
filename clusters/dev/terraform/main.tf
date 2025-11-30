resource "helm_release" "velero" {
  name       = "velero"
  repository = "https://vmware-tanzu.github.io/helm-charts"
  chart      = "velero"
  version    = "11.2.0"
  namespace  = "velero"

  set {
    name = "kubectl.image.tag"
    value = "1.33.4"
  }

  set {
    name  = "snapshotsEnabled"
    value = "false"
  }

  set {
    name  = "configuration.backupStorageLocations[0].name"
    value = "default"
  }

  set {
    name  = "configuration.backupStorageLocations[0].provider"
    value = "aws"
  }

  set {
    name  = "configuration.backupStorageLocations[0].bucket"
    value = var.velero_bucket_name
  }

  set {
    name  = "configuration.backupStorageLocations[0].config.region"
    value = "ru-central-1"
  }

  set {
    name  = "configuration.backupStorageLocations[0].config.s3ForcePathStyle"
    value = "true"
  }

  set {
    name  = "configuration.backupStorageLocations[0].config.s3Url"
    value = var.minio_endpoint
  }

  # Настройки credentials
  set {
    name  = "credentials.existingSecret"
    value = "velero-credentials"
  }

  set {
    name  = "credentials.useSecret"
    value = "true"
  }

  # Init containers для плагина AWS
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
}