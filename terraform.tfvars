# =============================================
# terraform.tfvars - Apni values yahan baro
# =============================================
# Is file ko rename karo: terraform.tfvars.example -> terraform.tfvars
# IMPORTANT: .gitignore mein terraform.tfvars add karo (sensitive data hai)

# ---- Zaroori Values (inhe zaroor change karo) ----
project_id = "project-a54ee2ee-1abc-4f95-a01"   # e.g., "my-project-12345"

# ---- Optional: Default values change karna ho to ----
region     = "asia-south1"            # Mumbai region
zone       = "asia-south1-a"
vm_name    = "my-gcp-vm"
machine_type = "e2-medium"            # 2 vCPU, 4GB RAM

# OS Image Options:
# Debian   -> "debian-cloud/debian-12"
# Ubuntu   -> "ubuntu-os-cloud/ubuntu-2204-lts"
# CentOS   -> "centos-cloud/centos-stream-9"
# Windows  -> "windows-cloud/windows-2022"
os_image   = "debian-cloud/debian-12"

disk_size_gb    = 20
disk_type       = "pd-balanced"
subnet_cidr     = "10.0.1.0/24"

# SSH key (apni public key paste karo)
ssh_user       = "devuser"
ssh_public_key = "ssh-rsa AAAA... your-email@example.com"

# Security: Sirf apna IP allow karo SSH ke liye
# ssh_source_ranges = ["YOUR.IP.ADDRESS/32"]
ssh_source_ranges = ["0.0.0.0/0"]

enable_http      = false
create_static_ip = true

# Startup script (optional)
startup_script = <<-EOT
  #!/bin/bash
  apt-get update -y
  apt-get install -y nginx
  systemctl start nginx
  systemctl enable nginx
EOT

labels = {
  environment = "dev"
  project     = "my-first-project"
  managed_by  = "terraform"
}
