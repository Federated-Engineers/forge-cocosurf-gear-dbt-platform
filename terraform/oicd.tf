# Reference the existing GitHub OIDC provider
data "aws_iam_openid_connect_provider" "github_oidc" {
  url = "https://token.actions.githubusercontent.com"
}


# GitHub Actions IAM Role
resource "aws_iam_role" "cocosurf_github_actions_role" {
  name = "cocosurf-github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"

        Principal = {
          Federated = data.aws_iam_openid_connect_provider.github_oidc.arn
        }

        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }

          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:Federated-Engineers@242844222/forge-cocosurf-gear-dbt-platform*:ref:refs/heads/main"
          }
        }
      }
    ]
  })
}


# ECR Push Permissions
resource "aws_iam_policy" "cocosurf_github_ecr_push_policy" {
  name        = "cocosurf_github_ecr_push"
  description = "Allows GitHub Actions to push images to Cocosurf ECR"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect   = "Allow"
        Action   = "ecr:GetAuthorizationToken"
        Resource = "*"
      },
      {
        Effect = "Allow"

        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]

        Resource = "arn:aws:ecr:eu-central-1:049417293525:repository/cocosurf-dbt"
      }
    ]
  })
}


# Attach ECR Policy to GitHub Actions Role
resource "aws_iam_role_policy_attachment" "cocosurf_github_ecr_push" {
  role       = aws_iam_role.cocosurf_github_actions_role.name
  policy_arn = aws_iam_policy.cocosurf_github_ecr_push_policy.arn
}
