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
 agent = 1
 clone = var.vm_clone_template
 cores      = var.aws_instance_types[var.aws_instance_type].cores
 memory     = var.aws_instance_types[var.aws_instance_type].memory
 scsihw   = "virtio-scsi-pci"  # Controlador SCSI para mayor rendimiento
 bootdisk = "scsi0"
 ciuser = "admin"
 cipassword = "admin"
   # Configuración del disco
  disk {
    size    = var.aws_instance_types[var.aws_instance_type].disk_size  # Tamaño del disco
    type    = "disk"           # Tipo de disco (VirtIO o SCSI es más eficiente para VMs)
    storage = var.vm_storage   # Almacenamiento donde se alojará el disco
    slot    = "sata0"          # Ubicación del disco (slot 0)
  }

  network {
    model  = var.vm_network_model          # Modelo de tarjeta de red (VirtIO para mejor rendimiento)
    bridge = var.vm_network_bridge         # Bridge de red (vmbr0 es el bridge por defecto)
  }
   # Habilitar DHCP para obtener una IP automáticamente
  ipconfig0 = var.vm_ipconfig0
}