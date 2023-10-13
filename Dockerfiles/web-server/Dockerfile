# Use an official WordPress image as the base image
FROM wordpress:latest

# Set environment variables for WordPress
ENV WORDPRESS_DB_HOST=db \
    WORDPRESS_DB_USER=root \
    WORDPRESS_DB_PASSWORD=password

# Copy custom themes or plugins 
COPY custom-plugins/ . home/var/www/html/wp-content/plugins/custom-plugins
COPY custom-themes/ . home/var/www/html/wp-content/themes/custom-themes


# Expose port 80
EXPOSE 80

# Start the WordPress server
CMD ["apache2-foreground"]
