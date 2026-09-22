# outputs.tf
# "outputs" are values Terraform prints after apply, and that other
# tools/scripts (or later, a remote backend config, or GitHub Actions)
# can read programmatically. Think of them as the "return value" of
# your Terraform run.

output "bucket_name" {
  description = "GCS bucket"
  value       = google_storage_bucket.lab_bucket.name
}

output "bucket_url" {
  description = "The gsutil URI of the bucket"
  value       = google_storage_bucket.lab_bucket.url
}
