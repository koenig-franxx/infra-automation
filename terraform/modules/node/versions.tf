terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc4"
    }
    ansible = {
      source = "ansible/ansible"
      version = "1.3.0"
    }
  }
}
