# resource "aws_iam_role" "ecs_task_execution" {
#   name = "cocosurf-ecs-task-execution-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"

#     Statement = [{
#       Effect = "Allow"

#       Principal = {
#         Service = "ecs-tasks.amazonaws.com"
#       }

#       Action = "sts:AssumeRole"
#     }]
#   })
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
#   role       = aws_iam_role.ecs_task_execution.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

# resource "aws_iam_role_policy" "ecs_task_execution_ssm" {
#   name = "cocosurf-ecs-ssm-access"
#   role = aws_iam_role.ecs_task_execution.id

#   policy = jsonencode({
#     Version = "2012-10-17"

#     Statement = [{
#       Effect = "Allow"

#       Action = [
#         "ssm:GetParameters",
#         "ssm:GetParameter"
#       ]

#       Resource = [
#         aws_ssm_parameter.snowflake_dbt_user.arn,
#         aws_ssm_parameter.snowflake_dbt_user_password.arn
#       ]
#     }]
#   })
# }



resource "aws_iam_role" "ecs_task_execution" {
  name = "cocosurf-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "cocosurf_dbt_task" {
  name = "cocosurf-dbt-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}
