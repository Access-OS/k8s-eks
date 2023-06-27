output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "eks_pod_policy_arn" {
  description = "IAM policy ARN for EKS pods"
  value       = aws_iam_policy.eks_pod_policy.arn
}

output "postgres_host" {
  description = "PostgreSQL Host"
  value       = aws_db_instance.default.address
}

output "redis_host" {
  description = "Redis Host"
  value       = aws_elasticache_cluster.accessos.cache_nodes.0.address
}