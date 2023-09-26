# Use an official WordPress image as the base image
FROM wordpress:latest

# Set environment variables for WordPress
ENV WORDPRESS_DB_HOST=db \
    WORDPRESS_DB_USER=root \
    WORDPRESS_DB_PASSWORD=password

# Copy custom themes or plugins 
COPY custom-theme /var/www/html/wp-content/themes/custom-theme
COPY custom-plugin /var/www/html/wp-content/plugins/custom-plugin

# Expose port 80
EXPOSE 80

# Start the WordPress server
CMD ["apache2-foreground"]
