# iam.tf
# Purpose: least-privilege identity for the VM.
#
# By default, a Compute Engine VM runs as the project's broad "default
# compute service account", which has more permissions than it needs.
# Real DevOps practice: give each workload its OWN service account
# with only the roles it actually requires. Here, our VM does nothing
# with other GCP APIs (it just runs Docker), so it gets almost no
# permissions — this is intentional and worth explaining in interviews.

resource "google_service_account" "vm_sa" {
  account_id   = "lab-vm-sa"
  display_name = "Service account for the lab Compute Engine VM"
}

# No roles are granted here on purpose — this VM doesn't need to call
# any GCP API itself (it only serves a web page via Docker). If it
# later needed to, say, read from the GCS bucket, you'd add a
# google_project_iam_member binding here scoped to exactly that role.
