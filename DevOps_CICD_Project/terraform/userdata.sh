#!/bin/bash
set -e

apt-get update -y
apt-get install -y docker.io

systemctl enable docker
systemctl start docker

sleep 20

docker pull rksingh2391998/devops-portfolio:latest

docker stop portfolio || true
docker rm portfolio || true

docker run -d \
--name portfolio \
-p 80:80 \
--restart unless-stopped \
rksingh2391998/devops-portfolio:latest

echo "Deployment Completed" > /home/ubuntu/status.txt