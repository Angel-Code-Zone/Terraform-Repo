#!/bin/bash

apt-get update -y
apt-get install -y docker.io

systemctl enable docker
systemctl start docker

echo "Application Server Ready" > /home/ubuntu/status.txt