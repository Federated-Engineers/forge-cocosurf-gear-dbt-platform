resource "aws_ecs_cluster" "cocosurf" {
  name = "cocosurf-dbt-cluster"
}

resource "aws_ecr_repository" "cocosurf_dbt" {
  name                 = "cocosurf-dbt"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_cloudwatch_log_group" "cocosurf_dbt" {
  name              = "/ecs/cocosurf-dbt"
  retention_in_days = 30
}

resource "aws_ecs_task_definition" "cocosurf_dbt" {
  family                   = "cocosurf-dbt"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"

  execution_role_arn = aws_iam_role.ecs_task_execution.arn
  task_role_arn      = aws_iam_role.cocosurf_dbt_task.arn

  container_definitions = jsonencode([
    {
      name      = "cocosurf-dbt"
      image     = "${aws_ecr_repository.cocosurf_dbt.repository_url}:latest"
      essential = true

      environment = [
        { name = "SNOWFLAKE_ACCOUNT", value = var.snowflake_account_name },
        { name = "SNOWFLAKE_USER", value = "COCOSURF_DBT_SVC" },
        { name = "SNOWFLAKE_ROLE", value = "DBT_ROLE" },
        { name = "SNOWFLAKE_DATABASE", value = "COCOSURF_DB" },
        { name = "SNOWFLAKE_WAREHOUSE", value = "COCOSURF_WH" },
        { name = "SNOWFLAKE_SCHEMA", value = "STAGING" }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.cocosurf_dbt.name
          awslogs-region        = "eu-central-1"
          awslogs-stream-prefix = "dbt"
        }
      }
    }
  ])
}
