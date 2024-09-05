provider "aws" {
  region = "us-east-1"  
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_security_group" "ecs" {
  vpc_id = aws_vpc.main.id
}

resource "aws_ecs_cluster" "main" {
  name = "medusa-cluster"
}

resource "aws_ecs_task_definition" "medusa" {
  family                   = "medusa-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "medusa-backend"
      image     = "YOUR_DOCKER_IMAGE_URI" # Replace with your Docker image URI
      essential = true
      portMappings = [
        {
          containerPort = 9000
          hostPort      = 9000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "medusa" {
  name            = "medusa-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.medusa.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.main.id]
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = true
  }
}
