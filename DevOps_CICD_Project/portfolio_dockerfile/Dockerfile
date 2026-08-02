# Use the official Nginx image
FROM nginx:alpine

# Remove the default Nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy portfolio files
COPY . /usr/share/nginx/html/

# Expose HTTP port
EXPOSE 80

# Health check
HEALTHCHECK CMD wget --no-verbose --tries=1 --spider http://localhost || exit 1

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]