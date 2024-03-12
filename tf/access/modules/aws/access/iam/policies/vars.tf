variable "group_name" {
  description = "group name policy to apply"
  type        = string
  default     = "" 
}


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
  type        = list
  default     = []
}