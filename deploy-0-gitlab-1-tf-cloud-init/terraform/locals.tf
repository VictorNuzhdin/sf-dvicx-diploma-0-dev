##--Local variables section
##  *set iam authorization token;
##  *set cloud id;
##  *set cloud Folder id;
##  *set cloud availability/access zone;
##  *set public ssh-key for remote vm ssh-connection;
#
locals {
  ##..cloud params
  iam_token           = var.yc_token
  cloud_id            = var.yc_cloud_id
  folder_id           = var.yc_folder_id
  access_zone         = "ru-central1-b"

  ##..vm network params
  netw_name           = "acme-net"
  net_id              = "enpjul7bs1mq29s7m5gf"
  net_sub_name        = "acme-net-sub1"
  net_sub_id          = "e2lcqv479p4bicmd33i1"

  ##..vm hardware params
  vm_hw_platform      = "standard-v2"
  vm_hw_cores         = 2
  vm_hw_ram_gb        = 4
  vm_hw_core_fract    = 5
  vm_isMayBeDisabled  = true

  ##..vm common  params
  vm_image_id         = "fd85u0rct32prepgjlv0"    # OS Image id (family_id: ubuntu-2204-lts, last_update: 2024-03-11, https://cloud.yandex.ru/ru/marketplace/products/yc/ubuntu-22-04-lts)
  vm_image_descr      = "Ubuntu 22.04 LTS"        # boot-disk description (optional)
  vm_disk_type        = "network-hdd"             # boot disk type (network-hdd | network-ssd)
  vm_disk_size_gb     = 20                        # boot dosk size, GiB (not less then 8GiB for "Ubuntu 22.04")
  #
  vm_name             = "gitlab"
  vm_hostname         = "gitlab"
  vm_net_ipv4_address = "10.0.10.11"
  vm_net_isNat        = true

  ##..ssh connection params
  vm_default_login    = "ubuntu"               # yandex cloud Ubuntu image default username
  ssh_keys_dir        = "/home/devops/.ssh"
  ssh_pubkey_path     = "/home/devops/.ssh/id_ed25519.pub"
  ssh_privkey_path    = "/home/devops/.ssh/id_ed25519"

}
