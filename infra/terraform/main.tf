provider "yandex" {
  #  token     = "AQAAAAAAq3znAATuwdI1L5efGkNgnowvh50i55c"
  #  cloud_id  = "b1g19ardnrl1r9c1pa8q"
  #  folder_id = "b1gd4kr6ve971563u1a6"
  #  zone      = "ru-central1-a"

  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

#инстанс для Гитлаба
resource "yandex_compute_instance" "gitlab_ins" {
  name                      = "gitlab"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 8
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 10
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  connection {
    type  = "ssh"
    host  = yandex_compute_instance.gitlab_ins.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file("${var.private_key_path}")
  }

  provisioner "remote-exec" {
    script = "files/gitlab.sh"
  }
}

# resource "yandex_compute_instance" "monitoring_ins" {
#     name = "monitoring"

#     resources {
#     cores  = 2
#     memory = 4
#     }

#     metadata = {
#     ssh-keys = "ubuntu:${file(var.public_key_path)}"
#     }

#     boot_disk {
#         initialize_params {
#         image_id = var.image_id
#         size = 50
#         type = "network-hdd"
#         }
#     }

#     network_interface {
#         subnet_id = var.subnet_id
#         nat       = true
#     }
# }


#Для хранения Docker-образов понадобится реестр Container Registry
resource "yandex_container_registry" "cont-reg" {
  name      = "container-registry"
  folder_id = var.folder_id
  labels = {
    contreg-label = "cr-label-value"
  }
}

module "cluster" {
  source	= "./modules/cluster"
}

