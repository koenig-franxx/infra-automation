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