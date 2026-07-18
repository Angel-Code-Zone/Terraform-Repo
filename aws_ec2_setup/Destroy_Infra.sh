#!/bin/bash

set -e

echo "========================================"
echo " Triggering Terraform Destroy Workflow"
echo "========================================"

# Check GitHub CLI
if ! command -v gh &> /dev/null
then
    echo "ERROR: GitHub CLI is not installed."
    exit 1
fi

# Check Authentication
if ! gh auth status &> /dev/null
then
    echo "ERROR: Please login using: gh auth login"
    exit 1
fi

echo "Triggering GitHub Actions workflow..."

gh workflow run terraform_destroy.yml \
    --repo Angel-Code-Zone/Terraform-Repo \
    --ref main

echo ""
echo "Terraform Destroy workflow triggered successfully."
echo "Visit GitHub Actions to monitor the progress."