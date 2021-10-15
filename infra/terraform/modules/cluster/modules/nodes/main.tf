#Создание группы узлов кластера
resource "yandex_kubernetes_node_group" "cluster_node_groups" {
  #  for_each = var.cluster_node_groups

  #  name = each.value["name"]
  #  description = each.value["name"]
  name        = "nodegroup"
  description = "nodegroup"
  version     = "1.17"
  #var.kube_version

  cluster_id = var.cluster_id
#"${yandex_kubernetes_cluster.cluster.id}"

  labels = {
    "group_name" = "gr_node_label"
    #each.value["name"]
  }

  instance_template {
    platform_id = "standard-v2"
#    nat         = true
    network_interface {
      nat        = true
      subnet_ids = ["e9bv6ogus3vf4er3u497"]
#,"e2lrpjht78f6gt2vfp79","b0cgeai6rn08btopu630"]
#["${yandex_vpc_subnet.subnet_resource_name.id}"]
    }
#    metadata = {
#      ssh-keys = "ubuntu:${file(var.public_key_path)}"
#      #var.ssh_keys
#    }

    resources {
      cores = 2
      #each.value["cpu"]
      memory = 4
      #each.value["memory"]
    }

    boot_disk {
      type = "network-hdd"
      #each.value["disk"]["type"]
      size = 32
      #each.value["disk"]["size"]
    }

    scheduling_policy {
      preemptible = false
    }
  }

  scale_policy {
    #    dynamic "auto_scale" {
    #      for_each = each.value["auto_scale"]
    #      content {
    #        min = auto_scale.value["min"]
    #        max = auto_scale.value["max"]
    #        initial = auto_scale.value["initial"]
    #      }
    #    }
    #    dynamic "fixed_scale" {
    #      for_each = each.value["fixed_scale"]
    #      content {
    #        size = fixed_scale.value
    #      }
    #    }
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    #    dynamic "location" {
    #      for_each = var.location_subnets
    #
    #      content {
    #        zone = location.value.zone
    #        subnet_id = location.value.id
    #      }
    #    }
    location {
      zone = "ru-central1-a"
    }
  }
}
