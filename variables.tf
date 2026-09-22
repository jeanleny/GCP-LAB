# variables.tf
# "variables" are Terraform's function parameters — they let the same
# code be reused for different projects/environments without editing
# main.tf. Think of this file as the *signature* of your config;
# terraform.tfvars (next file) provides the *values*.

variable "project_id" {
  description = "The GCP project ID to deploy into"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy resources into"
  type        = string
  default     = "europe-west9" # Paris
}

variable "zone" {
  description = "The GCP zone (a region is split into multiple zones for redundancy) to deploy the VM into"
  type        = string
  default     = "europe-west9-b"
}

variable "machine_type" {
  description = "The Compute Engine machine type (defines vCPU/RAM). e2-micro is the smallest/cheapest general-purpose type."
  type        = string
  default     = "e2-micro"
}
