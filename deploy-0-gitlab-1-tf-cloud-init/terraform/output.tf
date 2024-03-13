##..Collecting Output data (VM ipv4 addresses and other dynamic data)
output "host0_info" {
  value       = "${yandex_compute_instance.host0.name}: ${yandex_compute_instance.host0.hostname}: ${yandex_compute_instance.host0.network_interface.0.ip_address}: ${yandex_compute_instance.host0.network_interface.0.nat_ip_address}"
  description = "The hostname, external and internal (wan/lan) ipv4 addresses of VM instance"
  sensitive   = false
}

##..Collecting Output data (VM ipv4 address only)
output "host0_ip_external" {
  value       = "${yandex_compute_instance.host0.network_interface.0.nat_ip_address}"
  description = "The hostname, external and internal (wan/lan) ipv4 addresses of VM instance"
  sensitive   = false
}

##=EXAMPLE_OUTPUTS:
##    Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
##    Outputs:
##    host0_info = "gitlab: gitlab: 10.0.10.14: 158.160.28.67"
##    host0_ip_external = "158.160.28.67"
##
