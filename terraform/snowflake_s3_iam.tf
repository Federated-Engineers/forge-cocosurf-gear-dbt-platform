data "aws_caller_identity" "current" {}

locals {
  snowflake_s3_role_name = "cocosurf-snowflake-s3-role"

  snowflake_s3_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.snowflake_s3_role_name}"
}

resource "aws_iam_role" "snowflake_s3" {
  name = local.snowflake_s3_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"



    Statement = [
      {
        Effect = "Allow"

        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }

        Action = "sts:AssumeRole"

        Condition = {
          StringEquals = {
            "sts:ExternalId" = "TEMPORARY-COCOSURF-BOOTSTRAP"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "snowflake_s3_read" {
  name = "cocosurf-s3-read"
  role = aws_iam_role.snowflake_s3.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "ListLandedData"
        Effect = "Allow"

        Action = [
          "s3:GetBucketLocation",
          "s3:ListBucket"
        ]

        Resource = "arn:aws:s3:::cocosurf-gear-datalake"

        Condition = {
          StringLike = {
            "s3:prefix" = [
              "landed_data",
              "landed_data/*"
            ]
          }
        }
      },
      {
        Sid    = "ReadLandedDataObjects"
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ]

        Resource = "arn:aws:s3:::cocosurf-gear-datalake/landed_data/*"
      }
    ]
  })
}
