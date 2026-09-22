# outputs.tf
# "outputs" are values Terraform prints after apply, and that other
# tools/scripts (or later, a remote backend config, or GitHub Actions)
# can read programmatically. Think of them as the "return value" of
# your Terraform run.

output "bucket_name" {
  description = "The name of the created GCS bucket"
  value       = google_storage_bucket.lab_bucket.name
}

output "bucket_url" {
  description = "The gsutil URI of the bucket"
  value       = google_storage_bucket.lab_bucket.url
}

output "vm_external_ip" {
  description = "Public IP of the lab VM — open http://<this-ip> in a browser once startup.sh has finished (~1-2 min after apply)"
  value       = google_compute_instance.lab_vm.network_interface[0].access_config[0].nat_ip
}
