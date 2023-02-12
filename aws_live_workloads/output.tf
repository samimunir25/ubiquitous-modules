output "vpc_id" {
  value       = module.custom_vpc.this_vpc_id
  description = "VPC ID"
}

output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "The domain name of the load balancer"
}