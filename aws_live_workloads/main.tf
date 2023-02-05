module "webserver_cluster" {
  source = "../modules/compute/"

  cluster_name = "webservers-stage"
  instance_type = var.instance_type
  image_id      = var.image_id
  min_size      = var.min_size
  max_size      = var.max_size
}