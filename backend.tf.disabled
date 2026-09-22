# backend.tf
# A "backend" tells Terraform WHERE to store its state file, instead
# of the default (a local terraform.tfstate next to your .tf files).
#
# Here we point it at the exact bucket we just created with Terraform
# itself — Terraform will now store the record of its own state
# inside a resource it manages. This is a common, slightly
# mind-bending pattern in IaC: bootstrap a small piece of
# infrastructure with local state, then use that infrastructure to
# host the state for everything else.

terraform {
  backend "gcs" {
    bucket = "gcp-lab-leny-lab-bucket" # must match the bucket name main.tf creates
    prefix = "terraform/state"          # a "folder" inside the bucket to keep state tidy
  }
}
