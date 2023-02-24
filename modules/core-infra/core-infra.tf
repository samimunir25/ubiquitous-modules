### VPC ###

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
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

### Elastic IP ###

resource "aws_eip" "this" {
  depends_on = [aws_internet_gateway.this]
}

### Public NAT Gateway ###

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = var.nat_gw_tag
  }

}


### Public Subnets ###

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.this.id
  availability_zone       = var.availability_zone_a
  cidr_block              = var.public_subnet_a_cidr_block
  map_public_ip_on_launch = false
  depends_on              = [aws_internet_gateway.this]

  tags = {
    Name = var.pub_subnet_tag
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.this.id
  availability_zone       = var.availability_zone_b
  cidr_block              = var.public_subnet_b_cidr_block
  map_public_ip_on_launch = false
  depends_on              = [aws_internet_gateway.this]

  tags = {
    Name = var.pub_subnet_tag
  }
}


### Routing Table - Public Subnet ###

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = var.pub_route_table_tag
  }
}

### Routing Table Association - Public Subnets ###

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
  depends_on     = [aws_route_table.public]
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
  depends_on     = [aws_route_table.public]
}

### Private Subnets ###

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.this.id
  availability_zone       = var.availability_zone_a
  cidr_block              = var.private_subnet_a_cidr_block
  map_public_ip_on_launch = false

  tags = {
    Name = var.prv_subnet_tag
  }
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.this.id
  availability_zone       = var.availability_zone_b
  cidr_block              = var.private_subnet_b_cidr_block
  map_public_ip_on_launch = false

  tags = {
    Name = var.prv_subnet_tag
  }
}

### Routing Table - Private Subnet ###

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = var.prv_subnet_tag
  }
}

### Routing Table Association - Private Subnets ###

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
  depends_on     = [aws_route_table.private]
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
  depends_on     = [aws_route_table.private]
}

output "this_vpc_id" {
  value       = aws_vpc.this.id
  description = "VPC ID"
}

output "this_nat_gw_ip" {
  value       = aws_nat_gateway.this.public_ip
  description = "Public IP of NAT Gateway"
}