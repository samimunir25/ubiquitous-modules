module "webserver_cluster" {
  source = "../modules/compute/?ref=v0.0.1"

  cluster_name = "webserver-stage"
  instance_type = var.instance_type
  image_id      = var.image_id
  min_size      = var.min_size
  max_size      = var.max_size
  server_port   = var.server_port
}