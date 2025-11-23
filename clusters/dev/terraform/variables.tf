variable "minio_endpoint" {
  description = "MinIO endpoint URL"
  type        = string
  default     = "http://minio.minio.svc.cluster.local:9000"
}

variable "velero_bucket_name" {
  description = "Bucket name for Velero backups"
  type        = string
  default     = "velero-backups"
}