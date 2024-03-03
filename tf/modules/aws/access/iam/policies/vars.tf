variable "region" {
  description = "region"
  type        = string
  default     = "eu-west-3" 
}

variable "entity" {
  description = "entity prefix"
  type        = string
  default     = "Solcomputing"
}

variable "arnaccount" {
  description = "arn account policy"
  type        = string
  default     = "*"
}