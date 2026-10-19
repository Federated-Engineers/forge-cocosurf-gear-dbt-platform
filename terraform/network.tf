resource "aws_vpc" "cocosurf" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "cocosurf-vpc"
  }
}

resource "aws_subnet" "cocosurf_public" {
  vpc_id                  = aws_vpc.cocosurf.id
  cidr_block              = "10.20.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "cocosurf-public-subnet"
  }
}

resource "aws_internet_gateway" "cocosurf" {
  vpc_id = aws_vpc.cocosurf.id

  tags = {
    Name = "cocosurf-igw"
  }
}

resource "aws_route" "cocosurf_internet" {
  route_table_id         = aws_vpc.cocosurf.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.cocosurf.id
}

resource "aws_security_group" "cocosurf_ecs" {
  name        = "cocosurf-ecs-sg"
  description = "Security group for Cocosurf ECS Fargate tasks"
  vpc_id      = aws_vpc.cocosurf.id

  # No inbound rules are required for the dbt task.

  tags = {
    Name = "cocosurf-ecs-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "cocosurf_https" {
  security_group_id = aws_security_group.cocosurf_ecs.id
  description       = "Allow HTTPS connections to Snowflake and AWS services"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

output "cocosurf_vpc_id" {
  description = "VPC hosting Cocosurf ECS Fargate tasks"
  value       = aws_vpc.cocosurf.id
}

output "cocosurf_public_subnet_id" {
  description = "Public subnet for Cocosurf ECS Fargate tasks"
  value       = aws_subnet.cocosurf_public.id
}

output "cocosurf_ecs_security_group_id" {
  description = "Security group for Cocosurf ECS Fargate tasks"
  value       = aws_security_group.cocosurf_ecs.id
}
