##--Terraform Providers section
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.108.1"
    }
  }
  required_version = ">= 1.7.3"
}

##--Provider cloud authorization section
provider "yandex" {
  token     = local.iam_token
  cloud_id  = local.cloud_id
  folder_id = local.folder_id
  zone      = local.access_zone
}

##--
##--VM creation section
resource "yandex_compute_instance" "host0" {
  name        = local.vm_name
  hostname    = local.vm_hostname
  platform_id = local.vm_hw_platform
  zone        = local.access_zone

  ##..VM virtual CPU and RAM configuration
  resources {
    cores         = local.vm_hw_cores
    memory        = local.vm_hw_ram_gb
    core_fraction = local.vm_hw_core_fract
  }

  ##..VM Cloud maintenance configuration
  scheduling_policy {
    preemptible = local.vm_isMayBeDisabled
  }

  ##..VM boot-disk configuration (includes OS image from Yandex.Cloud Marketplace)
  boot_disk {
    initialize_params {
      image_id    = local.vm_image_id
      type        = local.vm_disk_type
      size        = local.vm_disk_size_gb
      description = local.vm_image_descr
    }
  }

  ##..Network interface configuration
  network_interface {
    subnet_id  = local.net_sub_id
    ip_address = local.vm_net_ipv4_address
    nat        = local.vm_net_isNat
  }

  ##..VM metadata configureation (including user data required for ssh connection)
  metadata = {
    serial-port-enable = 0
    #
    #..user management: basics: adds public ssh-key to default user
    #ssh-keys = "${local.vm_default_login}:${file("${local.ssh_pubkey_path}")}"
    #
    #..user management: adavnced: using Cloud-Init OS feature
    user-data = "${file("configs/cloud-init.yaml")}"
  }

}
