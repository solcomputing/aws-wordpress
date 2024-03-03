variable "organisation" {
  description = "Group"
  type        = string
  default     = "administrators"
}

variable "group_name" {
  description = "Group"
  type        = string
  default     = "administrators"
}

variable "group_iam" {
  description = "Group Policy"
  type        = map(object({
                group_name      = string
                groups          = list(string)
                group_members   = list(string)
                group_policies  = list(string)
  }))
  default     = {
        group = {
                group_name      = ""
                groups          = [""]
                group_members   = [""]
                group_policies  = [""]
                }
  } 
}

variable "policies" {
}