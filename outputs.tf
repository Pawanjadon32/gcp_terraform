# =============================================
# outputs.tf - Apply ke baad ye info milegi
# =============================================

output "vm_name" {
  description = "VM ka naam"
  value       = google_compute_instance.vm_instance.name
}

output "vm_internal_ip" {
  description = "VM ka internal (private) IP address"
  value       = google_compute_instance.vm_instance.network_interface[0].network_ip
}

output "vm_external_ip" {
  description = "VM ka external (public) IP address"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "static_ip_address" {
  description = "Static IP address (agar create_static_ip = true ho)"
  value       = var.create_static_ip ? google_compute_address.static_ip[0].address : "N/A"
}

output "ssh_command" {
  description = "VM se connect karne ka command"
  value       = "gcloud compute ssh ${var.ssh_user}@${google_compute_instance.vm_instance.name} --zone=${var.zone}"
}

output "network_name" {
  description = "VPC Network ka naam"
  value       = google_compute_network.vpc_network.name
}

output "subnet_name" {
  description = "Subnet ka naam"
  value       = google_compute_subnetwork.subnet.name
}

output "service_account_email" {
  description = "VM ke Service Account ka email"
  value       = google_service_account.vm_sa.email
}
