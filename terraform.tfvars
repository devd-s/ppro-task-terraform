region = "us-east-1"

vpc_cidr            = "10.0.0.0/16"
availability_zones  = ["us-east-1a", "us-east-1b", "us-east-1c"]

cluster_name    = "my-eks-cluster"
cluster_version = "1.22"

allowed_cidr_blocks = ["0.0.0.0/0"]

# Spot instances
spot_desired_capacity = 2
spot_max_capacity     = 5
spot_min_capacity     = 1
spot_instance_type    = "t3.large"

# On-demand instances
on_demand_desired_capacity = 2
on_demand_max_capacity     = 3
on_demand_min_capacity     = 1
on_demand_instance_type    = "t3.medium"

key_name = "test-ssh-key"
