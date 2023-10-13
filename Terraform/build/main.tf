module "imaginary-client" {
  source       = "../modules/terraform-aws-ecr"
  stage        = var.environment
  name         = "ecr-${var.appcomponent}"
  use_fullname = false
}

# Define an ECS cluster
resource "aws_ecs_cluster" "wordpress_cluster" {
  name = "wordpress-cluster"
}

# Define a task definition for WordPress
resource "aws_ecs_task_definition" "wordpress_task" {
  family                   = "wordpress"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([{
    name  = "wordpress"
    image = "your-wordpress-image-url" # Replace with your WordPress image URL
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
}

# Define a task definition for MySQL
resource "aws_ecs_task_definition" "mysql_task" {
  family                   = "mysql"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([{
    name  = "mysql"
    image = "your-mysql-image-url" # Replace with your MySQL image URL
    portMappings = [{
      containerPort = 3306
      hostPort      = 3306
    }]
  }])
}

# Define an IAM role for ECS task execution
resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

# Define an ECS service for WordPress
resource "aws_ecs_service" "wordpress_service" {
  name            = "wordpress-service"
  cluster         = aws_ecs_cluster.wordpress_cluster.id
  task_definition = aws_ecs_task_definition.wordpress_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets = ["subnet-0361a4cacced162cd"] # Replace with your subnet IDs
  }
}



# Define a VPC and other networking resources if needed.


