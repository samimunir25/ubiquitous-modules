### VPC ###

resource "aws_vpc" "this" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

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

### Subnet ###

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnet_cidr_block

  tags = {
    Name = var.subnet_tag
  }
}

### Routing Table ###

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = aws_subnet.this.id
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = var.route_table_tag
  }
}