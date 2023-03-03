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

variable "os_language" {
  type        = string
  description = "The VM operating system lanugage."
  default     = "en_US"
}

variable "os_keyboard" {
  type        = string
  description = "The VM operating system keyboard input."
  default     = "us"
}

variable "os_timezone" {
  type        = string
  description = "The VM operating system timezone."
  default     = "UTC"
}

variable "ssh_public_key" {
  type        = string
  description = "Public key that will be inserted to the VM (uses Vagrant insecure key by default)"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"
}