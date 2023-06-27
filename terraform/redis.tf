resource "aws_elasticache_subnet_group" "accessos" {
  name       = "aws-cache-subnet-group"
  subnet_ids = module.vpc.private_subnets
}

module "elasticache_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "accessos-redis"
  description = "RDS Security Group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      description = "Redis access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]
}

resource "aws_elasticache_cluster" "accessos" {
  cluster_id           = "accessos"
  engine               = "redis"
  node_type            = "cache.m6g.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.0"
  port                 = 6379

  subnet_group_name = aws_elasticache_subnet_group.accessos.name
  security_group_ids = [module.elasticache_security_group.security_group_id]

  snapshot_retention_limit = 5
  snapshot_window          = "00:00-05:00"
}
