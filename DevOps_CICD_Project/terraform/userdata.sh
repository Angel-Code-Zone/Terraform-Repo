#!/bin/bash

set -e

apt-get update -y

apt-get install -y docker.io

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu

mkdir -p /opt/portfolio

echo "Application Server Ready" > /home/ubuntu/status.txt