variable "cluster_encryption_config_kms_key_enable_key_rotation" {
  type        = bool
  description = "Cluster Encryption Config KMS Key Resource argument - enable kms key rotation"
  default     = true
}

variable "cluster_encryption_config_kms_key_deletion_window_in_days" {
  type        = number
  description = "Cluster Encryption Config KMS Key Resource argument - key deletion windows in days post destruction"
  default     = 10
}

variable "cluster_encryption_config_kms_key_policy" {
  type        = string
  description = "Cluster Encryption Config KMS Key Resource argument - key policy"
  default     = null
}

variable "cluster_encryption_config_kms_key_id" {
  type        = string
  description = "KMS Key ID to use for cluster encryption config"
  default     = ""
}

variable "cluster_encryption_config_enabled" {
  type        = bool
  description = "Set to `true` to enable Cluster Encryption Configuration"
  default     = true
}

variable "clustername" {
  type        = string
  description = "EKS Cluster Name"
  default     = "WORDPRESS"
}

variable "eks_cluster_region" {
   type        = string
   description = "EKS Cluster Region"
   default     = "eu-west-3"
}

variable "eks_policy_user" {
   type        = string
   description = "Account builder"
   default     = "xxxxxxxx" 
}