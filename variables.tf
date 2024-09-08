variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "my-vpc"
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "allowed_cidr_blocks" {
  description = "Allowed CIDR blocks for ingress"
  default     = ["0.0.0.0/0"]
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  default     = "my-eks-cluster"
}

variable "cluster_version" {
  description = "EKS Cluster Version"
  default     = "1.22"
}

# Spot instance group variables
variable "spot_desired_capacity" {
  type        = number
  default     = 2
}

variable "spot_max_capacity" {
  type        = number
  default     = 5
}

variable "spot_min_capacity" {
  type        = number
  default     = 1
}

variable "spot_instance_type" {
  type        = string
  default     = "t3.large"
}

# On-demand instance group variables
variable "on_demand_desired_capacity" {
  type        = number
  default     = 2
}

variable "on_demand_max_capacity" {
  type        = number
  default     = 3
}

variable "on_demand_min_capacity" {
  type        = number
  default     = 1
}

variable "on_demand_instance_type" {
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "SSH key name for EC2 instances"
  type        = string
}
