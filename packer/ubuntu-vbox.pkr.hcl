packer {
  required_plugins {
    virtualbox = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
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

  post-processors {
    post-processor "vagrant" {
      output = "${var.box_name}.box"
    }
  }
}
