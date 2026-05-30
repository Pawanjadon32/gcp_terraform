resource "google_compute_instance" "vm" {
  name         = "dev-vm"
  machine_type = "e2-medium"
  zone         = "asia-south1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 20
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata = {
    ssh-keys = "pawan:${file("id_ed25519.pub")}"
  }

  tags = ["ssh"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["ssh"]
}