# Use lightweight Nginx as the web server
FROM nginx:alpine

# Copy our website into Nginx's default web directory
COPY index.html /usr/share/nginx/html/index.html

# Nginx listens on port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]