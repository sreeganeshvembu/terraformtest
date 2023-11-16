variable "project_name" {
  default = "Top-105"
}

variable "environment" {
  default = "dev"
}

variable "location" {
  default = "Germany West Central" # Note: Azure uses "Germany West Central" for West Germany
}

variable "common_tags" {
  default = {
    "project_name"    = "SaVe"
    "deployment_type" = "IAAC"
    "deployment_date" = "16-11-2023"
    "environment"     = "dev"
  }
}
