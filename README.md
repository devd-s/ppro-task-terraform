## AWS EKS Terraform Infrastructure with Networking and Backend State in S3

This repository defines infrastructure using Terraform, including a modular setup for AWS resources such as VPCs, subnets, security groups, and an EKS (Elastic Kubernetes Service) cluster. It also uses S3 for backend state management and DynamoDB for state locking.

## Features

- Modular Infrastructure: The Terraform code is modular, allowing easy reuse and scalability.
- Network Isolation: Separate public, private, and master private subnets across multiple availability zones to enhance security.
- EKS Deployment: A secure EKS cluster deployment with worker nodes running in private subnets and the EKS control plane in master private subnets.
- NAT Gateway: Ensures that instances in private subnets can access the internet without exposing them directly to inbound traffic.
- Load Balancer: An Application Load Balancer (ALB) deployed in public subnets to route traffic to the EKS worker nodes in private subnets.
- Spot and On-Demand EC2 Instances: Utilizes different instance types through launch templates to optimize cost and performance.
- State Management: Uses an S3 bucket for remote state storage.


# Initialize the Terraform project
'terraform init'

# Running terraform plan (We also just plan which will show the plan on terminal or from wherever you're running )
'terraform plan -out=plan.out'  

# Applying the plan 
terraform apply plan.out


# Two key modules are defined:

Networking Module: Manages the VPC, public, private, and master private subnets, security groups, NAT Gateway, and route tables.

EKS Module: Manages the EKS cluster and worker nodes, using separate launch templates for spot and on-demand instances.

# To provide input variables terraform terraform.tfvars files will be used.

