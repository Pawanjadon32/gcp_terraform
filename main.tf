# ---- VPC Network ----
resource "google_compute_network" "vpc_network" {
  name                    = "${var.vm_name}-network"
  auto_create_subnetworks = false
}

# ---- Subnet ----
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.vm_name}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# ---- Firewall: SSH Allow ----
resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.vm_name}-allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_source_ranges
  target_tags   = ["ssh-access"]
}

# ---- Firewall: HTTP/HTTPS Allow (optional) ----
resource "google_compute_firewall" "allow_http" {
  count   = var.enable_http ? 1 : 0
  name    = "${var.vm_name}-allow-http"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

# ---- Static External IP ----
resource "google_compute_address" "static_ip" {
  count  = var.create_static_ip ? 1 : 0
  name   = "${var.vm_name}-static-ip"
  region = var.region
}

# ---- Compute Instance (VM) ----
resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = concat(
    ["ssh-access"],
    var.enable_http ? ["http-server"] : []
  )

  boot_disk {
    initialize_params {
      image = var.os_image
      size  = var.disk_size_gb
      type  = var.disk_type
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id

    access_config {
      nat_ip = var.create_static_ip ? google_compute_address.static_ip[0].address : null
    }
  }

  metadata = {
    ssh-keys = var.ssh_public_key != "" ? "${var.ssh_user}:${var.ssh_public_key}" : null
  }

  metadata_startup_script = var.startup_script

  service_account {
    email  = google_service_account.vm_sa.email
    scopes = ["cloud-platform"]
  }

  labels = var.labels

  lifecycle {
    ignore_changes = [metadata["ssh-keys"]]
  }
}

# ---- Service Account for VM ----
resource "google_service_account" "vm_sa" {
  account_id   = "${var.vm_name}-sa"
  display_name = "Service Account for ${var.vm_name}"
}
