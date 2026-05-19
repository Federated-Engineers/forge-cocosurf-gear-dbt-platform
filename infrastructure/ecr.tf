resource "aws_ecr_repository" "cocosurf" {
  name                 = "${var.team}-${var.ecr-use-case}-${var.env}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = local.common_tags
}

# setting archive policy on images
resource "aws_ecr_lifecycle_policy" "cocosurf-policy" {
  repository = aws_ecr_repository.cocosurf.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Archive images not pulled in 60 days",
      "selection": {
        "tagStatus": "any",
        "countType": "sinceImagePulled",
        "countUnit": "days",
        "countNumber": 60
      },
      "action": {
        "type": "transition",
        "targetStorageClass": "archive"
      }
    }
  ]
}
EOF
}