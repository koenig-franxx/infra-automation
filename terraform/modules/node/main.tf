provider "proxmox" {
 pm_api_url   = var.pm_api_url
 pm_api_token_id = var.pm_api_token_id
 pm_api_token_secret  = var.pm_api_token_secret
 pm_tls_insecure = var.pm_tls_insecure
}

resource "proxmox_vm_qemu" "my_vm" {
 count       = var.vm_count
 name = "${var.aws_instance_type}-${var.vm_name_prefix}-${var.vm_count}-${count.index + 1}" # Nombra las VMs de manera secuencial t2.micro_aws-instance_100
 desc        = "${var.vm_clone_template}-${count.index + 1}"
 target_node = var.vm_target_node
 sshkeys = var.vm_ssh_key
 agent = 0
 clone = var.vm_clone_template
 cores      = var.aws_instance_types[var.aws_instance_type].cores
 memory     = var.aws_instance_types[var.aws_instance_type].memory
 scsihw   = var.vm_scsihw  # Controlador SCSI para mayor rendimiento
 bootdisk = var.vm_bootdisk
 ciuser = var.vm_ciuser
 cipassword = var.vm_cipassword  

 disks {
    ide {
        ide2 {
            cloudinit {
                storage = var.vm_storage
            }
        }
    }
    scsi {
        scsi0 {
            disk {
            format = "raw"
            size = var.aws_instance_types[var.aws_instance_type].disk_size
            storage  = var.vm_storage  
            }
        }

    }
}
  network {
    model  = var.vm_network_model          # Modelo de tarjeta de red (VirtIO para mejor rendimiento)
    bridge = var.vm_network_bridge         # Bridge de red (vmbr0 es el bridge por defecto)
  }
   # Habilitar DHCP para obtener una IP automáticamente
  ipconfig0 = var.vm_ipconfig0

   # Habilitar tiempo de espera adicional para Cloud-Init
  timeouts {
    create = "30m"
  }
}