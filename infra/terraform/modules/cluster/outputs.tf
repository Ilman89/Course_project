#output "external_ip_address_app" {
#  value = yandex_compute_instance.gitlab_ins.network_interface.0.nat_ip_address
#}
output "kubeconfig_duplicate" {
  value = "${local.kubeconfig}"
}
output "external_v4_endpoint" {
  value = yandex_kubernetes_cluster.cluster.master[0].external_v4_endpoint
}
output "ca_certificate" {
  value = yandex_kubernetes_cluster.cluster.master[0].cluster_ca_certificate
}
