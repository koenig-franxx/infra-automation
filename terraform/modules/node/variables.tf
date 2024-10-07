########################### Variables para el proveedor de Proxmox ################################
variable "pm_api_token_id" {
  description = "Token id para conectar con Proxmox"
  type        = string
  default     = "terraform-prov@pve!o2"
}
variable "pm_api_token_secret"{
  description = "Token id secret para conectar con proxmox"
  type        = string
  default     = "8d0e14fb-9a30-41f9-9ba9-daed77b2903a"
}
variable "pm_tls_insecure"{
  description = "Para conectar con proxmox sin certificado SSL"
  type        = string
  default     = true
}
#################################################################################################
variable "aws_instance_types" {
  description = "Configuraciones de las VMs simulando los tipos de instancias de AWS"
  type = map(object({
    cores    = number
    memory   = number
    disk_size = string
  }))

  default = {
    "t2.micro" = {
      cores    = 1
      memory   = 1024
      disk_size = "8G"
    },
    "t3.medium" = {
      cores    = 2
      memory   = 4096
      disk_size = "20G"
    },
    "m5.large" = {
      cores    = 2
      memory   = 8192
      disk_size = "40G"
    },
    "c5.xlarge" = {
      cores    = 4
      memory   = 8192
      disk_size = "80G"
    },
    "r5.2xlarge" = {
      cores    = 8
      memory   = 16384
      disk_size = "160G"
    }
  }
}

variable "aws_instance_type" {
  description = "Tipo de instancia de AWS (simulada en Proxmox)"
  type        = string
  default     = "t2.micro"  # Cambia el tipo de instancia aquí según las necesidades
}

variable "vm_count" {
  description = "Número de VMs a crear"
  type        = number
  default     = 1  # Ajusta la cantidad de VMs que necesitas
}

variable "vm_name_prefix" {
  description = "Prefijo para los nombres de las VMs"
  type        = string
  default     = "aws-instance"
}

variable "vm_desc_prefix" {
  description = "Prefijo para las descripciones de las VMs"
  type        = string
  default     = "AWS-like-VM"
}

variable "vm_ssh_key" {
  description = "Clave pública SSH para acceder a las VMs"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCO7H2NC7EEHQToLQxHoEzuQYfFs7oQLdwFkzvnCw7M7ZgleOVW1Oxt3jXjVolm/CF+AI7jNKNI6CzopiY8liPhBRL85IelYNZmx7SKwe+3SOfIiBJCESNdF8NtgB7y1vEtEX5Z6o0mBSQ9S47KndEYIpX5LpqBtTrBmOibE/90PBrVzp/N1mq7NqASBkIUU7KTNY6TGbkPH4TalKZQAPSfG997nlc2ttuaJUoUACvJi5PuclqBBiMPs8gGkaRg3TSgZhMoTAMluOFnYRW/wyXRXJYyMFXjW3jMPeYU07GUCgkbvj9z04FCOvuFz91mBVBVozoPdlp0zP9GSJcTIm0r diego@DESKTOP-K60CMBK"
}

variable "vm_target_node" {
  description = "Nodo Proxmox donde se creará la VM"
  type        = string
  default     = "strelizia-prox"
}

variable "vm_clone_template" {
  description = "Plantilla de clonación para la VM"
  type        = string
  default     = "debian12-cloudinit"
}

variable "vm_network_model" {
  description = "Modelo de tarjeta de red de la VM"
  type        = string
  default     = "virtio"
}

variable "vm_network_bridge" {
  description = "Bridge de red para la VM"
  type        = string
  default     = "vmbr0"
}

variable "vm_storage" {
  description = "Almacenamiento para la VM en el pool zfs-saiyan-nas"
  type        = string
  default     = "zfs-saiyan-nas"
}

variable "vm_ipconfig0" {
  description = "Habilitar DHCP para obtener una IP automáticamente"
  type        = string
  default     = "ip=dhcp"
}