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