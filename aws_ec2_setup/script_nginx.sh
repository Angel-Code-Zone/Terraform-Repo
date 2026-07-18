#!/bin/bash

# first update the ec2 instance.
# install nginx on ec2 instance.

# Update the package repository
apt-get update -y

# Install necessary packages
apt-get install -y nginx

# Start the Nginx service
systemctl start nginx

# Enable Nginx to start on boot
systemctl enable nginx

# Create a simple HTML page
echo "<h1> Hello, Learning the Terraform </h1>" >>  /var/www/html/index.nginx-debian.html

# Adjust the firewall to allow HTTP traffic
ufw allow 'Nginx Full'

# Restart nginx to ensure it's serving content
systemctl restart nginx