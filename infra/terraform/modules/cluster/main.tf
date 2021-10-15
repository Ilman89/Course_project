#Создание кластера k8s
resource "yandex_kubernetes_cluster" "cluster" {
  name = "kubercluster"

  network_id = "enpej1uhb35h2q15jmqd"

  master {
    regional {
      region = "ru-central1"

      location {
        zone = "ru-central1-a"
        #${yandex_vpc_subnet.default-ru-central1-a.zone}"
        subnet_id = "e9bv6ogus3vf4er3u497"
        #${yandex_vpc_subnet.default-ru-central1-a.id}"
      }

      location {
        zone = "ru-central1-b"
        #${yandex_vpc_subnet.default-ru-central1-b.zone}"
        subnet_id = "e2lrpjht78f6gt2vfp79"
        #${yandex_vpc_subnet.default-ru-central1-b.id}"
      }

      location {
        zone = "ru-central1-c"
        #${yandex_vpc_subnet.default-ru-central1-c.zone}"
        subnet_id = "b0cgeai6rn08btopu630"
        #${yandex_vpc_subnet.default-ru-central1-c.id}"
      }
    }

    version   = "1.17"
    public_ip = true
  }
  #  service_account_id = var.cluster_service_account_id
  #  node_service_account_id = var.node_service_account_id
  service_account_id = "ajecpefipu0veq3tar82"
  #${yandex_iam_service_account.packer-user.id}"
  node_service_account_id = "ajecpefipu0veq3tar82"
  #${yandex_iam_service_account.packer-user.id}"


  release_channel = "STABLE"

  # depends_on = [
  #    "packer-user"
  # ]

}

module "cluster_nodes"{
  source = "./modules/nodes"
  cluster_id = yandex_kubernetes_cluster.cluster.id
}


locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${yandex_kubernetes_cluster.cluster.master[0].external_v4_endpoint}
    certificate-authority-data: ${base64encode(yandex_kubernetes_cluster.cluster.master[0].cluster_ca_certificate)}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: yc
  name: ycmk8s
current-context: ycmk8s
users:
- name: yc
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: yc
      args:
      - k8s
      - create-token
KUBECONFIG
}
output "kubeconfig" {
  value = "${local.kubeconfig}"
}
