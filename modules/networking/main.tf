provider "aws" {
  region = var.region
}

# Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# ------------------- Public, Private, and Master Subnets --------------------

# Public Subnets 
resource "aws_subnet" "public_subnets" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index * 3)  # CIDR for each AZ
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index}"
  }
}

# Private Subnets (used for EKS worker nodes)
resource "aws_subnet" "private_subnets" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index * 3 + 1)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index}"
  }
}

# Master Private Subnets (for EKS control plane)
resource "aws_subnet" "master_private_subnets" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index * 3 + 2)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.vpc_name}-master-private-subnet-${count.index}"
  }
}

# ------------------- NAT Gateway & Internet Gateway --------------------

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_gw_ip" {
  vpc = true
}

# NAT Gateway in Public Subnet
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_ip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }
}

# Internet Gateway for Public Subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# ------------------- Route Tables and Associations --------------------

# Public Route Table Route to the Internet Gateway)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table Routes to NAT Gateway for outbound internet access
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}

# Create a route for the private subnets to the NAT Gateway
resource "aws_route" "private_internet_access" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private_subnet_association" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
