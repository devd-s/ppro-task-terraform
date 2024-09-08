output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main_vpc.id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = aws_subnet.private_subnets[*].id
}

output "master_private_subnet_ids" {
  description = "Master Private Subnet IDs (for EKS Control Plane)"
  value       = aws_subnet.master_private_subnets[*].id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.nat_gw.id
}

output "app_lb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.app_lb.arn
}
