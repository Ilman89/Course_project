output "gitlab_ip_address" {
  value = yandex_compute_instance.gitlab_ins.network_interface.0.nat_ip_address
}

