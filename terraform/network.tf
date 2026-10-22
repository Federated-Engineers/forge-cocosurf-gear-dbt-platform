data "aws_vpc" "secure_production" {
  id = "vpc-09a5fdb174ed7c060"
}

data "aws_subnet" "secure_production_public_a" {
  id = "subnet-0613b8ccd258f4cca"
}

data "aws_subnet" "secure_production_public_b" {
  id = "subnet-0af2d376a426b58bb"
}

resource "aws_security_group" "cocosurf_ecs" {
  name        = "cocosurf-ecs-sg"
  description = "Security group for Cocosurf ECS Fargate tasks"
  vpc_id      = data.aws_vpc.secure_production.id

  tags = {
    Name    = "cocosurf-ecs-sg"
    Project = "Cocosurf"
  }
}

resource "aws_vpc_security_group_egress_rule" "cocosurf_https" {
  security_group_id = aws_security_group.cocosurf_ecs.id
  description       = "Allow outbound HTTPS connections"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

output "cocosurf_vpc_id" {
  description = "Existing secure-production company VPC"
  value       = data.aws_vpc.secure_production.id
}

output "cocosurf_public_subnet_a_id" {
  description = "Secure-production-public-a subnet ID"
  value       = data.aws_subnet.secure_production_public_a.id
}

output "cocosurf_public_subnet_b_id" {
  description = "Secure-production-public-b subnet ID"
  value       = data.aws_subnet.secure_production_public_b.id
}

output "cocosurf_ecs_security_group_id" {
  description = "Dedicated security group for Cocosurf ECS tasks"
  value       = aws_security_group.cocosurf_ecs.id
}