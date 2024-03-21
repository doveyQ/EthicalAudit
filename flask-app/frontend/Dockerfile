# Use the official Nginx base image
FROM nginx:latest

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy the custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the SSL certificates to the appropriate directory
#COPY ./ssl/letsencrypt/live/example.com/fullchain.pem /etc/nginx/certs/fullchain.pem
#COPY ./ssl/letsencrypt/live/example.com/privkey.pem /etc/nginx/certs/privkey.pem

COPY ssl-params.conf /etc/nginx/snippets/

# Copy the frontend files to the Nginx html directory
COPY ./ /usr/share/nginx/html/

# Expose port 80 and 443
EXPOSE 80
EXPOSE 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

