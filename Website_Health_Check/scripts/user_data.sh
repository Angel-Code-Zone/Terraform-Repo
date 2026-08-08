#!/bin/bash

set -e

exec > >(tee -a /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

echo "========================================="
echo "Starting Website Health Check setup"
echo "========================================="

# -----------------------------------------
# Variables
# -----------------------------------------

DOCKER_IMAGE="${docker_image}"
DOCKER_USERNAME="${docker_username}"
DOCKER_TOKEN="${docker_token}"

S3_BUCKET="${s3_bucket}"

APP_DIR="/opt/website"

# -----------------------------------------
# Update system
# -----------------------------------------

apt-get update -y

# -----------------------------------------
# Install required packages
# -----------------------------------------

apt-get install -y \
  docker.io \
  awscli \
  curl \
  unzip \
  cron

# -----------------------------------------
# Start Docker
# -----------------------------------------

systemctl enable docker
systemctl start docker

echo "Docker installed successfully."

# -----------------------------------------
# Create application directory
# -----------------------------------------

mkdir -p "$APP_DIR"

# -----------------------------------------
# Create Dockerfile
# -----------------------------------------

echo "${dockerfile_b64}" | base64 -d > "$APP_DIR/Dockerfile"

# -----------------------------------------
# Create index.html
# -----------------------------------------

echo "${index_html_b64}" | base64 -d > "$APP_DIR/index.html"

# -----------------------------------------
# Login to Docker Hub
# -----------------------------------------

echo "$DOCKER_TOKEN" | docker login \
  -u "$DOCKER_USERNAME" \
  --password-stdin

echo "Docker Hub login successful."

# -----------------------------------------
# Build Docker image
# -----------------------------------------

cd "$APP_DIR"

docker build \
  -t "$DOCKER_IMAGE" \
  .

echo "Docker image built successfully."

# -----------------------------------------
# Push image to Docker Hub
# -----------------------------------------

docker push "$DOCKER_IMAGE"

echo "Docker image pushed successfully."

# -----------------------------------------
# Remove existing container if present
# -----------------------------------------

docker rm -f website-container 2>/dev/null || true

# -----------------------------------------
# Pull image again from Docker Hub
# -----------------------------------------

docker pull "$DOCKER_IMAGE"

echo "Docker image pulled successfully."

# -----------------------------------------
# Run website container
# -----------------------------------------

docker run -d \
  --name website-container \
  --restart unless-stopped \
  -p 80:80 \
  "$DOCKER_IMAGE"

echo "Website container started."

# -----------------------------------------
# Install health-check scripts
# -----------------------------------------

echo "${server_health_script_b64}" | base64 -d > /usr/local/bin/server_health_check.sh

echo "${web_health_script_b64}" | base64 -d > /usr/local/bin/web_health_check.sh

chmod +x /usr/local/bin/server_health_check.sh
chmod +x /usr/local/bin/web_health_check.sh

# -----------------------------------------
# Create local log directories
# -----------------------------------------

mkdir -p /var/log/website-health
mkdir -p /var/log/server-health

# -----------------------------------------
# Create cron jobs
# Every 2 minutes
# -----------------------------------------

cat > /etc/cron.d/website-health-check <<EOF
*/2 * * * * root /usr/local/bin/server_health_check.sh
*/2 * * * * root /usr/local/bin/web_health_check.sh
EOF

chmod 644 /etc/cron.d/website-health-check

# -----------------------------------------
# Run health checks immediately
# -----------------------------------------

/usr/local/bin/server_health_check.sh || true

/usr/local/bin/web_health_check.sh || true

echo "========================================="
echo "Website Health Check setup completed"
echo "========================================="