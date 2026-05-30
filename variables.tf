# =============================================
# variables.tf - Saare variables yahan define hain
# =============================================

# ---- Project Settings ----
variable "project_id" {
  description = "Aapka GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region (e.g., asia-south1 for Mumbai)"
  type        = string
  default     = "asia-south1"
}

variable "zone" {
  description = "GCP Zone (e.g., asia-south1-a)"
  type        = string
  default     = "asia-south1-a"
}

# ---- VM Settings ----
variable "vm_name" {
  description = "VM ka naam"
  type        = string
  default     = "my-gcp-vm"
}

variable "machine_type" {
  description = "VM ka machine type (e.g., e2-micro, n2-standard-2)"
  type        = string
  default     = "e2-medium"
}

variable "os_image" {
  description = "Boot disk ka OS image"
  type        = string
  default     = "debian-cloud/debian-12"
}

variable "disk_size_gb" {
  description = "Boot disk ka size GB mein"
  type        = number
  default     = 20
}

variable "disk_type" {
  description = "Boot disk ka type (pd-standard, pd-ssd, pd-balanced)"
  type        = string
  default     = "pd-balanced"
}

# ---- Network Settings ----
variable "subnet_cidr" {
  description = "Subnet ke liye CIDR range"
  type        = string
  default     = "10.0.1.0/24"
}

variable "ssh_source_ranges" {
  description = "SSH access ke liye allowed IP ranges"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Production mein apna IP lagao
}

variable "enable_http" {
  description = "HTTP/HTTPS firewall rule enable karna hai?"
  type        = bool
  default     = false
}

# ---- SSH Key Settings ----
variable "ssh_user" {
  description = "SSH login ke liye username"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key" {
  description = "SSH public key ka content (e.g., 'ssh-rsa AAAA...')"
  type        = string
  default     = ""
  sensitive   = true
}

# ---- Static IP ----
variable "create_static_ip" {
  description = "VM ke liye static external IP banana hai?"
  type        = bool
  default     = true
}

# ---- Startup Script ----
variable "startup_script" {
  description = "VM start hone par run hone wala script"
  type        = string
  default     = ""
}

# ---- Labels ----
variable "labels" {
  description = "VM par lagane ke liye labels"
  type        = map(string)
  default = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
