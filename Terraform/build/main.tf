resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


module "imaginary-client-wordpress" {
  source       = "../modules/terraform-aws-ecr"
  stage        = var.environment
  name         = "ecr-${var.appcomponent1}"
  use_fullname = false
}

module "imaginary-client-mysql" {
  source       = "../modules/terraform-aws-ecr"
  stage        = var.environment
  name         = "ecr-${var.appcomponent2}"
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
    image = "017432918922.dkr.ecr.eu-west-1.amazonaws.com/ecr-imaginary-client-wordpress" # Replace with your WordPress image URL
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
    image = "017432918922.dkr.ecr.eu-west-1.amazonaws.com/ecr-imaginary-client-mysql" # Replace with your MySQL image URL
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

# Attach the IAM policy to the ECS execution role
resource "aws_iam_role_policy_attachment" "ecr_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs_execution_role.name
}

resource "aws_iam_role_policy_attachment" "ecr_read_only_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Define an ECS service for WordPress
resource "aws_ecs_service" "wordpress_service" {
  name            = "wordpress-service"
  cluster         = aws_ecs_cluster.wordpress_cluster.id
  task_definition = aws_ecs_task_definition.wordpress_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets = [aws_subnet.my_subnet.id] # Replace with your subnet IDs
    security_groups = [aws_security_group.ecs_sg.id]
  }
}




