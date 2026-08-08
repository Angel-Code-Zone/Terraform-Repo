#!/bin/bash

echo "=========================================="
echo " Website Health Check - Destroy Infra"
echo "=========================================="

REPO="Angel-Code-Zone/Terraform-Repo"
WORKFLOW="terraform_destroy_Server_status.yml"
BRANCH="main"

echo ""
echo "Triggering Terraform Destroy workflow..."
echo ""

gh workflow run "$WORKFLOW" \
  --repo "$REPO" \
  --ref "$BRANCH"

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo " Destroy workflow triggered successfully!"
    echo "=========================================="
    echo ""
    echo "Terraform will now destroy the infrastructure"
    echo "through GitHub Actions."
    echo ""
    echo "You can check the workflow in GitHub Actions."
else
    echo ""
    echo "ERROR: Failed to trigger destroy workflow."
    echo "Please check your GitHub CLI login."
    exit 1
fi