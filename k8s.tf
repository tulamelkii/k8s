terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a"
}

resource "yandex_iam_service_account" "sa-terra" { 
   name        =  "SAterra"
   folder_id   =  "b1g89cjo0roopb2d5s14"
   description =  "service account from folder k8s-terra"
}         
resource "yandex_resourcemanager_folder_iam_member" "editor" {
   folder_id   = "b1g89cjo0roopb2d5s14"
   role        = "editor"
   member      = "serviceAccount:${ yandex_iam_service_account.sa-terra.id }"
   depends_on  = [ yandex_iam_service_account.sa-terra ]
}

resource "yandex_vpc_address" "vpc_k8s_pub_ip" {
   name        = "PUBip"
   folder_id   = "b1g89cjo0roopb2d5s14"
   external_ipv4_address {
     zone_id   = "ru-central1-a"
  }
}
resource "yandex_vpc_network" "vpc_k8s_net" {
   folder_id   = "b1g89cjo0roopb2d5s14"
   name        = "NETk8s"
   description = "virtual network cluster k8s for ru-central1-a"
}

resource "yandex_vpc_subnet" "vpc_k8s_sub" {
   folder_id      = "b1g89cjo0roopb2d5s14"
   name           = "SUBk8s"
   description    = "virtual subnet cluster k8s for ru-central1-a"
   v4_cidr_blocks = ["192.168.1.0/28"]
   network_id     = yandex_vpc_network.vpc_k8s_net.id 
   zone           = "ru-central1-a"
}

resource "yandex_compute_instance_group" "control_inst_group" {
  folder_id           = "b1g89cjo0roopb2d5s14"
  name                = "CONinsGROUP"
  service_account_id  = "${ yandex_iam_service_account.sa-terra.id }"
  depends_on          = [ yandex_resourcemanager_folder_iam_member.editor ]
}
