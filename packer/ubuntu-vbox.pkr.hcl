packer {
  required_plugins {
    virtualbox = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

variable "box_name" {
  type    = string
  default = "ubuntu-jammy-k8s"
}

variable "install_disk_url" {
  type    = string
  default = "http://releases.ubuntu.com/jammy/ubuntu-22.04.2-live-server-amd64.iso"
}

variable "checksum" {
  type    = string
  default = "sha256:5e38b55d57d94ff029719342357325ed3bda38fa80054f9330dc789cd2d43931"
}

variable "os_user" {
  type = string
}

variable "os_password" {
  type = string
}

variable "vm_disk_size" {
  type    = number
  default = 30000
}

variable "vm_ram_size" {
  type    = number
  default = 1024
}

source "virtualbox-iso" "ubuntu" {
  guest_os_type    = "Ubuntu_64"
  vm_name          = var.box_name
  iso_url          = var.install_disk_url
  iso_checksum     = var.checksum
  ssh_username     = var.os_user
  ssh_password     = var.os_password
  disk_size        = var.vm_disk_size
  memory           = var.vm_ram_size
  http_directory   = "http"
  headless         = true
  shutdown_command = "echo ${var.os_password} | sudo -S systemctl poweroff"
  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--uartmode1", "disconnected"]
  ]

  boot_command = [
    "c",
    "linux /casper/vmlinuz --- autoinstall ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/' ",
    "<enter><wait>",
    "initrd /casper/initrd<enter><wait>",
    "boot<enter>"
  ]
}

build {
  sources = ["sources.virtualbox-iso.ubuntu"]

  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done"
    ]
  }
}
