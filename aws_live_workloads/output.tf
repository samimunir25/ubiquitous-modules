output "vpc_id" {
  value       = module.custom_vpc.this_vpc_id
  description = "VPC ID"
}

output "this_nat_gw_ip" {
  value       = module.custom_vpc.this_nat_gw_ip
  description = "Public IP of NAT Gateway"
}

output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "The domain name of the load balancer"
}