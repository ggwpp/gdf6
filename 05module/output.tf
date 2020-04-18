output "private_ip" {
  value = "google_compute_instance.vm_instance.network_interface.network_ip"
}
output "public_ip" {
  value = "google_compute_instance.vm_instance.network_interface.access_config.nat_ip"
}
