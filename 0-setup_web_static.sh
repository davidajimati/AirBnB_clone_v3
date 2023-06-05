#!/usr/bin/env bash
# script that sets up your web servers for the deployment of web_staticscript that sets up your web servers for the deployment of web_staticscript that sets up your web servers for the deployment of web_staticscript that sets up your web servers for the deployment of web_staticscript that sets up your web servers for the deployment of web_staticscript that sets up your web servers for the deployment of web_staticscript that sets up your web servers for the deployment of web_staticscript that sets up your web servers for the deployment of web_staticscript that sets up your web servers for the deployment of web_staticscript that sets up your web servers for the deployment of web_staticscript that sets up your web servers for the deployment of web_static

# install nginx
apt-get update
apt-get install -y nginx

# create necessary directories
mkdir -p /data/web_static/releases/
mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/releases/test/
touch /data/web_static/releases/test/index.html

# create a test html file to confirm nginx configuration
printf %s "
Your nginx is workin correctly
" > /data/web_static/releases/test/index.html

# create symbolic link
link_path="/data/web_static/current"
target_path="/data/web_static/releases/test"

if [ -L "$link_path" ]; then
    rm "$link_path"
fi
ln -s "$target_path" "$link_path"

# change folder user and groub to ubuntu
chown -R ubuntu /data/
chgrp -R ubuntu /data/

# configure nginx to serve hbnb static

printf %s "server {
    listen 80;
    listen [::]:80;
    root /etc/nginx/html;
    index index.html index.htm index.nginx-debian.html
    server_name _;

    location /hbnb_static {
        alias /data/web_static/current/;
        }

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }

    error_page 404 /404.html;
    location = /etc/nginx/html/404.html {
      internal;
    }
}" > /etc/nginx/sites-available/default

# restart nginx
service nginx restart
