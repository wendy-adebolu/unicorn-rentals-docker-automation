# Unicorn Rentals Docker Automation
Unicorn Rentals is exploring Docker on AWS for deploying their WordPress Blogs. This project aims to automate the Docker image building and deployment process using AWS ECR, Terraform, CI/CD pipelines, and AWS ECS or Fargate.

## Project Overview
### Unicorn Rentals' objectives are:

- Build a web server container for running the WordPress software.
- Create a database container to host the MySQL database for WordPress.
- Use AWS ECR to securely store custom Docker container images.
- Implement CI/CD pipelines to build Docker images and store them in AWS ECR.
- Utilize AWS ECS or Fargate for container orchestration.
- Employ Infrastructure as Code (IaC) with Terraform for managing AWS infrastructure.
- Maintain a Git repository with Dockerfiles for both web and database containers.

  
## Implement three pipelines for different tasks:

1. Web Server Container Pipeline
Automatically triggered on changes to the WordPress web server Dockerfile.
Builds the container image.
Tags and pushes the web server image to AWS ECR.

2. Database Container Pipeline
Automatically triggered on changes to the MySQL database Dockerfile.
Builds the container image.
Tags and pushes the MySQL database image to AWS ECR.

3. Infrastructure Deployment Pipeline
Triggered on changes to the Terraform code.
Plans and deploys AWS infrastructure for ECS/Fargate.
Retrieves the latest Docker images created by the other pipelines from AWS ECR.

### Repository Structure
```
unicorn-rentals-docker-automation/
│
├── Dockerfiles/
│   ├── web-server/
│   │   └── Dockerfile
│   ├── database/
│   │   └── Dockerfile
│
├── infrastructure/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── ...
│
├── .gitignore
├── README.md
└── ...
```
## Getting Started
Follow these steps to get started with the project:

#### Clone this repository.
- Set up your AWS credentials and configure your environment.
- Modify the Dockerfiles in the Dockerfiles/ directory as needed.
- Configure the Terraform code in the infrastructure/ directory to match your infrastructure requirements.
- Set up CI/CD pipelines to automate Docker image building and infrastructure deployment.
- Run the pipelines and deploy your application.
## Resources
- WordPress
- License

### This project is licensed under the MIT License - see the LICENSE file for details.

### Acknowledgments
- Terraform
- AWS ECS
- AWS ECR
