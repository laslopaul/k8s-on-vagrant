variable "box_name" {
  type        = string
  description = "Name of Vagrant box artifact"
  default     = "ubuntu-jammy-k8s"
}

variable "install_disk_url" {
  type        = string
  description = "URL of Ubuntu installation disk image"
  default     = "http://releases.ubuntu.com/jammy/ubuntu-22.04.2-live-server-amd64.iso"
}

variable "checksum" {
  type        = string
  description = "Checksum of Ubuntu installation disk"
  default     = "sha256:5e38b55d57d94ff029719342357325ed3bda38fa80054f9330dc789cd2d43931"
}

variable "os_user" {
  type        = string
  description = "Username for VM login"
  sensitive   = true
}

variable "os_password" {
  type        = string
  description = "Password for VM login"
  sensitive   = true
}

variable "vm_disk_size" {
  type        = number
  description = "Size of VM disk in megabytes"
  default     = 30000
}

variable "vm_ram_size" {
  type        = number
  description = "Size of VM memory in megabytes"
  default     = 1024
}