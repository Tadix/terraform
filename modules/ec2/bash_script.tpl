#!/bin/bash
sudo apt update -y &&
sudo apt install -y nginx
echo "Hello from ${instance_name_count}" > /var/www/html/index.html