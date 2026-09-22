# variables.tf
# "variables" are Terraform's function parameters — they let the same
# code be reused for different projects/environments without editing
# main.tf. Think of this file as the *signature* of your config;
# terraform.tfvars (next file) provides the *values*.

variable "project_id" {
  description = "GCP id"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west9" # Paris
}
