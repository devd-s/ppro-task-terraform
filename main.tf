provider "aws" {
  region = var.region
}

# Networking module
module "networking" {
  source              = "./modules/networking"
  region              = var.region
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  availability_zones  = var.availability_zones
  allowed_cidr_blocks = var.allowed_cidr_blocks
}

# EKS module
module "eks" {
  source            = "./modules/eks"
  cluster_name      = var.cluster_name
  cluster_version   = var.cluster_version
  vpc_id            = module.networking.vpc_id
  security_group_id = module.networking.eks_security_group_id

  # Worker nodes private subnets
  subnets           = module.networking.private_subnet_ids

  # EKS Control plane master private subnets
  master_subnets    = module.networking.master_private_subnet_ids

  # Spot and On-demand instances for EKS worker nodes
  spot_desired_capacity = var.spot_desired_capacity
  spot_max_capacity     = var.spot_max_capacity
  spot_min_capacity     = var.spot_min_capacity
  spot_instance_type    = var.spot_instance_type

  on_demand_desired_capacity = var.on_demand_desired_capacity
  on_demand_max_capacity     = var.on_demand_max_capacity
  on_demand_min_capacity     = var.on_demand_min_capacity
  on_demand_instance_type    = var.on_demand_instance_type

  key_name = var.key_name
}

output "load_balancer_arn" {
  description = "Load Balancer ARN"
  value       = module.networking.app_lb_arn
}
