
module "test_node" {
  source = "../../modules/node"  # Ruta hacia el módulo node
  aws_instance_type = "t3.medium"
}