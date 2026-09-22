# terraform.tfvars
# Terraform automatically loads this file and uses it to fill in the
# variables declared in variables.tf. This is where YOUR specific
# values live, kept separate from the reusable variables.tf logic.
# In a real team, this file (or its equivalent) is often gitignored
# or per-environment (dev.tfvars, prod.tfvars) — here it's simple
# enough to keep visible so you can see the values clearly.

project_id   = "gcp-lab-leny"
region       = "europe-west9"
zone         = "europe-west9-b"
machine_type = "e2-micro"
