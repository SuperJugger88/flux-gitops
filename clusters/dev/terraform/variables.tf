variable "minio_access_key" {
  description = "MinIO access key"
  type        = string
  sensitive   = true
}

variable "minio_secret_key" {
  description = "MinIO secret key"
  type        = string
  sensitive   = true
}

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