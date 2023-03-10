packer {
  required_plugins {
    virtualbox = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

locals {
  autoinstall_data = {
    "/meta-data" = file("${abspath(path.root)}/data/meta-data")
    "/user-data" = templatefile("${abspath(path.root)}/data/user-data.pkrtpl", {
      os_user        = var.os_user
      os_password    = bcrypt(var.os_password)
      os_language    = var.os_language
      os_keyboard    = var.os_keyboard
      os_timezone    = var.os_timezone
      ssh_public_key = var.ssh_public_key
    })
  }
}

source "virtualbox-iso" "ubuntu" {
  guest_os_type    = "Ubuntu_64"
  vm_name          = var.box_name
  iso_url          = var.install_disk_url
  iso_checksum     = var.checksum
  ssh_username     = var.os_user
  ssh_password     = var.os_password
  ssh_timeout      = "40m"
  disk_size        = var.vm_disk_size
  memory           = var.vm_ram_size
  http_content     = local.autoinstall_data
  headless         = true
  shutdown_command = "sudo systemctl poweroff"
  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--uartmode1", "disconnected"],
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]
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
      output            = "${abspath(path.root)}/artifacts/${var.box_name}.box"
      compression_level = 9
    }
  }
}
