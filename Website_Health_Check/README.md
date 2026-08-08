Website Health Check Infrastructure Deployment (Mini Project)
📋 Project Overview

AWS website health monitoring infrastructure deployed using Terraform, Docker, and GitHub Actions. The project provisions a public Application Load Balancer with a private EC2 web server running a Dockerized website, with automated server and website health checks.

🎯 Key Features
Infrastructure as Code: AWS infrastructure provisioned using Terraform
Remote State: Terraform state stored securely in an S3 backend
Network Security: ALB is public while the EC2 server remains in a private subnet
Load Balancing: Application Load Balancer provides public access to the website
Private Server: EC2 has no direct public access
Internet Access: NAT Gateway provides outbound internet access to the private EC2
Containerized Website: Website runs inside Docker
Docker Automation: EC2 installs Docker, builds the image, pushes it to Docker Hub, pulls it again, and runs the container
Server Monitoring: Server health is checked every 2 minutes
Website Monitoring: Website health is checked every 2 minutes
Centralized Logs: Server and website health logs are stored separately in S3
CI/CD: GitHub Actions automatically deploys the infrastructure
Automated Cleanup: GitHub Actions destroy workflow can be triggered using a local Bash script

                    ┌───────────────┐
                    │   Developer   │
                    └───────┬───────┘
                            │
                         git push
                            │
                            ▼
                    ┌───────────────┐
                    │    GitHub     │
                    └───────┬───────┘
                            │
                            ▼
                    ┌───────────────┐
                    │GitHub Actions │
                    └───────┬───────┘
                            │
                            ▼
                      Terraform
                            │
                            ▼
                         AWS VPC
                            │
                ┌───────────┴───────────┐
                │                       │
           Public Subnets          Private Subnet
                │                       │
                ▼                       ▼
               ALB                     EC2
                                        │
                                      Docker
                                        │
                                     Website
                                        │
                         ┌──────────────┴──────────────┐
                         │                             │
                  Server Health                 Website Health
                         │                             │
                         └──────────────┬──────────────┘
                                        │
                                        ▼
                                       S3
                                  Health Logs
                                        │
                                        ▼
                                       S3
                                       ├── server-health/
                                       └── website-health/

📁 Code Structure
Website_Health_Check
│
├── .github
│   └── workflows
│       ├── terraform_deploy_Server_status.yml
│       └── terraform_destroy_Server_status.yml
│
├── bootstrap
│   └── main.tf
│
├── Dockerfile_Website
│   ├── Dockerfile
│   └── index.html
│
├── scripts
│   ├── user_data.sh
│   ├── server_health_check.sh
│   ├── web_health_check.sh
│   └── destroy_infra.sh
│
└── terraform
    ├── backend.tf
    ├── main.tf
    ├── variables.tf
    ├── terraform.tfvars
    ├── vpc.tf
    ├── security_group.tf
    ├── iam.tf
    ├── ec2_alb.tf
    └── outputs.tf