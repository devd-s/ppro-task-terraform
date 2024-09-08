output "eks_cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  description = "EKS Cluster Security Group ID"
  value       = module.eks.cluster_security_group_id
}

output "eks_node_group_arns" {
  description = "EKS Node Group ARNs"
  value       = module.eks.node_group_arns
}

output "eks_node_group_names" {
  description = "EKS Node Group Names"
  value       = module.eks.node_group_names
}
