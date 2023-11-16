variable "project_name" {
  default = "Top-105"
}

variable "environment" {
  default = "dev"
}

variable "location" {
  default = "Germany West Central"  # Adjust as per your Azure region
}

variable "common_tags" {
  default = {
    "project_name"    = "SaVe"
    "deployment_type" = "IAAC"
    "deployment_date" = "16-11-2023"
    "environment"     = "dev"
  }
}
