module "eks" {
  source          = "terraform-aws-modules/eks/aws" # Using aws eks terraform module
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  
  vpc_id          = var.vpc_id
  
  # Specifying subnets that will be used by the EKS cluster
  subnets         = var.private_subnet_ids        # Worker nodes will use private subnets
  
  # The master_private_subnet_ids are used here for the EKS control plane
  control_plane_subnet_ids = var.master_private_subnet_ids
  
  security_group_ids = [var.security_group_id]
  
  node_groups = {
    spot_group = {
      desired_capacity = var.spot_desired_capacity
      max_capacity     = var.spot_max_capacity
      min_capacity     = var.spot_min_capacity
      instance_type    = var.spot_instance_type
      key_name         = var.key_name
    }

    on_demand_group = {
      desired_capacity = var.on_demand_desired_capacity
      max_capacity     = var.on_demand_max_capacity
      min_capacity     = var.on_demand_min_capacity
      instance_type    = var.on_demand_instance_type
      key_name         = var.key_name
    }
  }
}
