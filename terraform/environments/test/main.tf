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

module "kubernetes_master" {
  source = "../../modules/node"  # Ruta hacia el módulo node
  aws_instance_type = "t3.medium"
  vm_name_prefix = "hokage-k8s-master"
}

module "kubernetes_worker" {
  source = "../../modules/node"  # Ruta hacia el módulo node
  aws_instance_type = "t2.micro"
  vm_name_prefix = "shinobi-k8s-worker"
  vm_count = 2
}

module "grafana_node" {
  source = "../../modules/node"  # Ruta hacia el módulo node
  aws_instance_type = "t2.micro"
  vm_name_prefix = "sharingan-grafana"
}

resource "ansible_host" "sharingan-grafana" {
  name   = "sharingan-grafana"
  groups = ["monitoring"]

  variables = {
    greetings   = "from host!"
    some        = "variable"
    yaml_hello  = local.decoded_vault_yaml.hello
    yaml_number = local.decoded_vault_yaml.a_number

    # using jsonencode() here is needed to stringify 
    # a list that looks like: [ element_1, element_2, ..., element_N ]
    yaml_list = jsonencode(local.decoded_vault_yaml.a_list)
  }
}