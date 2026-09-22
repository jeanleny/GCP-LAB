# main.tf
# This file declares WHICH provider Terraform should talk to, and WHAT
# resources you want to exist. Terraform reads every .tf file in the
# folder and merges them into one plan — splitting into main.tf /
# variables.tf / outputs.tf is a convention, not a requirement.

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 8.0"
    }
  }
}

# The provider block tells Terraform HOW to authenticate and WHERE to
# send API calls by default. It reads your local gcloud credentials
# automatically (the application-default login you set up earlier).
provider "google" {
  project = var.project_id
  region  = var.region
}

# --- Resource #1: a Cloud Storage bucket ---
# This is the smallest, cheapest, safest thing you can create on GCP.
# Syntax: resource "<PROVIDER_TYPE>" "<LOCAL_NAME>" { ...config... }
# "google_storage_bucket" is defined by the provider (not something
# you invent) — Terraform providers ship a schema for every resource
# type they support.
resource "google_storage_bucket" "lab_bucket" {
  name          = "${var.project_id}-lab-bucket"
  location      = var.region
  force_destroy = true # allows `terraform destroy` to delete it even if it has files in it

  # Uniform bucket-level access is the modern, simpler IAM model GCP
  # recommends over legacy per-object ACLs.
  uniform_bucket_level_access = true

  # Lifecycle rule: auto-delete objects older than 7 days.
  # This is here purely so you can show you understand lifecycle
  # policies, a real cost-control concept cloud teams care about.
  lifecycle_rule {
    condition {
      age = 7
    }
    action {
      type = "Delete"
    }
  }
}
