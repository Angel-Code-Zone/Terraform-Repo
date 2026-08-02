#!/bin/bash
set -e

# Log everything
exec > >(tee /var/log/user-data.log) 2>&1

echo "===== Starting Jenkins Server Setup ====="

# Update system
apt-get update -y
apt-get upgrade -y

# Install required packages
apt-get install -y \
curl \
wget \
git \
unzip \
zip \
ca-certificates \
gnupg \
software-properties-common \
apt-transport-https \
lsb-release \
openssh-client

######################################################
# Install Java 21
######################################################

apt-get install -y openjdk-21-jdk

java -version

######################################################
# Install Docker
######################################################

install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
gpg --dearmor -o /etc/apt/keyrings/docker.gpg

chmod a+r /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo $VERSION_CODENAME) stable" \
| tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y

apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable docker
systemctl start docker

usermod -aG docker ubuntu

######################################################
# Install AWS CLI v2
######################################################

cd /tmp

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip

unzip awscliv2.zip

./aws/install

aws --version

######################################################
# Install Terraform
######################################################

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo \
"deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com \
$(lsb_release -cs) main" \
| tee /etc/apt/sources.list.d/hashicorp.list

apt-get update -y

apt-get install -y terraform

terraform version

######################################################
# Install Jenkins
######################################################

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo \
"deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" \
| tee /etc/apt/sources.list.d/jenkins.list > /dev/null

apt-get update -y

apt-get install -y jenkins

systemctl enable jenkins
systemctl start jenkins

######################################################
# Permissions
######################################################

usermod -aG docker jenkins

systemctl restart docker
systemctl restart jenkins

echo "===== Installation Completed ====="