variable "eks_cluster_type" {
  default = true
  description = "Enable / fetch cluster eks"
  type = bool
}

variable "eks_cluster_name" {
  description = "Name of the Kubernetes cluster. This string is used to contruct the AWS IAM permissions and roles."
  type        = string
}

variable "eks_namespace" {
  description = "Kubernetes namespace to deploy the AWS Load Balancer Controller into."
  type        = string
  default     = "default"
}

variable "eks_replicas" {
  description = "Amount of replicas to be created."
  type        = number
  default     = 1
}