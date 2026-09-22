#!/bin/bash
# startup.sh
# This script runs automatically as root the FIRST time the VM boots
# (GCP calls it the "startup script" mechanism). Terraform doesn't
# execute this itself — it just uploads the script as VM metadata;
# the Google Guest Agent already installed on the OS image is what
# actually runs it on boot.

set -euxo pipefail

# Install Docker using the official convenience script (fine for a
# lab; in production you'd pin versions and use a proper package repo).
curl -fsSL https://get.docker.com | sh

systemctl enable docker
systemctl start docker

# Run a simple nginx container on port 80, restart automatically if
# it ever crashes or the VM reboots.
docker run -d \
  --name lab-nginx \
  --restart unless-stopped \
  -p 80:80 \
  nginx:stable
