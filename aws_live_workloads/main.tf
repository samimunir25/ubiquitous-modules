module "webserver_cluster" {
  source = "github.com/samimunir25/ubiquitous-modules//modules/compute?ref=v0.0.2"

  cluster_name  = "webserver-stage"
  vpc_id        = var.vpc_id
  instance_type = var.instance_type
  image_id      = var.image_id
  min_size      = var.min_size
  max_size      = var.max_size
  server_port   = var.server_port
}