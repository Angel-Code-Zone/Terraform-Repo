# This is the resources file.

# Create new repository by terraform
resource "github_repository" "Demo_Repository" {
  name        = "Demo-Repo"
  description = "This is Demo Repository, created by using the terraform code"
  visibility  = "public"
  auto_init   = true
}

resource "github_repository" "Terraform_Repository" {
  name        = "Terraform-Repo"
  description = "Learning terraform infrastructure as code with aws cloud"
  visibility  = "public"
  auto_init   = false
}

resource "github_repository" "linux_Repository" {
  name        = "Linux-Repo"
  description = "Learning linux and scripting with aws cloud & linux machines"
  visibility  = "public"
  auto_init   = false
}

resource "github_repository" "Docker_Repository" {
  name        = "Docker-Repo"
  description = "Learning docker with linux & DockerHub projects"
  visibility  = "public"
  auto_init   = false
}

resource "github_repository" "Kubernetes_Repository" {
  name        = "Kubernetes-Repo"
  description = "Learning kubernetes with linux, Docker, Kind & Kubectl projects"
  visibility  = "public"
  auto_init   = false
}

output "Repo_url" {
  value = github_repository.Demo_Repository.html_url
}