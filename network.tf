# network.tf
# Purpose: control what traffic can reach the VM.
#
# We're using the project's "default" VPC network (GCP creates one
# automatically per project) to keep this basic. In a production
# setup you'd usually define a custom VPC + subnet explicitly instead
# of relying on the implicit default — worth mentioning as a known
# simplification if asked in an interview.

data "google_compute_network" "default" {
  name = "default"
}

# Firewall rule: allow SSH (22) so you can connect to debug, and
# HTTP (80) so you can see the Docker container's web page in a
# browser. GCP firewalls are DENY-by-default — nothing is reachable
# until a rule explicitly allows it. This is the opposite default
# from a typical home network, and a common interview question.
resource "google_compute_firewall" "allow_ssh_http" {
  name    = "lab-allow-ssh-http"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  # 0.0.0.0/0 = anywhere on the internet. Fine for a short-lived lab,
  # but NOT what you'd do in production — you'd scope source_ranges
  # to your office/VPN IP, or better, use Identity-Aware Proxy (IAP)
  # for SSH instead of exposing port 22 publicly at all.
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["lab-vm"]
}
