# compute.tf
# Purpose: the actual server. This resource brings together the
# service account (iam.tf), the network/firewall (network.tf), and
# the startup script (startup.sh) into one running VM.

resource "google_compute_instance" "lab_vm" {
  name         = "lab-vm"
  machine_type = var.machine_type
  zone         = var.zone

  # `tags` here are network tags, matched against the firewall rule's
  # target_tags in network.tf — this is how the firewall rule knows
  # WHICH VMs it applies to, rather than opening ports project-wide.
  tags = ["lab-vm"]

  boot_disk {
    initialize_params {
      # A minimal, well-supported OS image. `family` always points to
      # the latest image in that family, so this stays current.
      image = "debian-cloud/debian-12"
      size  = 10 # GB, smallest practical size for this OS
    }
  }

  network_interface {
    network = data.google_compute_network.default.name

    # An empty access_config block is what actually assigns a public
    # (ephemeral) external IP. Remove this block entirely and the VM
    # would have NO internet-facing IP at all — a common pattern for
    # internal-only workloads.
    access_config {}
  }

  # Terraform uploads this script's content as instance metadata;
  # the guest OS's startup-script agent executes it on first boot.
  metadata_startup_script = file("${path.module}/startup.sh")

  service_account {
    email  = google_service_account.vm_sa.email
    scopes = ["cloud-platform"] # scope = ceiling; actual permissions still governed by IAM roles above
  }
}
