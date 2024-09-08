variable "cluster_name" {
  description = "Name of EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "EKS version"
  type        = string
}

variable "subnets" {
  description = "Subnets where EKS worker nodes will be launched"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for EKS cluster"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for EKS"
  type        = string
}

# Spot Instance Group Variables
variable "spot_desired_capacity" {
  type        = number
  description = "Desired number of spot instances"
  default     = 2
}

variable "spot_max_capacity" {
  type        = number
  description = "Max number of spot instances"
  default     = 5
}

variable "spot_min_capacity" {
  type        = number
  description = "Min number of spot instances"
  default     = 1
}

variable "spot_instance_type" {
  type        = string
  description = "Instance type for spot instances"
  default     = "t3.large"
}

# On-demand Instance Group Variables
variable "on_demand_desired_capacity" {
  type        = number
  description = "Desired number of on-demand instances"
  default     = 2
}

variable "on_demand_max_capacity" {
  type        = number
  description = "Max number of on-demand instances"
  default     = 3
}

variable "on_demand_min_capacity" {
  type        = number
  description = "Min number of on-demand instances"
  default     = 1
}

variable "on_demand_instance_type" {
  type        = string
  description = "Instance type for on-demand instances"
  default     = "t3.medium"
}

variable "key_name" {
  description = "SSH key name for EC2 instances"
  type        = string
}
