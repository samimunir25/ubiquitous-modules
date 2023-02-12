### VPC ###

resource "aws_vpc" "this" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_tag
  }
}

### Internet Gateway ###

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.igw_tag
  }
}

### Public Subnet ###

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnet_cidr_block
  map_public_ip_on_launch = true
  depends_on = [aws_internet_gateway.this]

  tags = {
    Name = var.subnet_tag
  }
}

### Routing Table ###

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = var.route_table_tag
  }
}

### Routing Table Association ###

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
  depends_on = [aws_route_table.this]
}

output "this_vpc_id" {
  value       = aws_vpc.this.id
  description = "The domain name of the load balancer"
}