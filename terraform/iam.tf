resource "aws_iam_policy" "eks_pod_policy" {
  name        = "EKS-Pod-Policy"
  path        = "/accessos/"
  description = "AccessOS EKS Pod Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:*",
          "sts:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
