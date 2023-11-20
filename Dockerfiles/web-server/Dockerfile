# Use an official WordPress image as the base image
FROM wordpress:latest

# Set environment variables for WordPress
# Note: Update these values with your actual database configuration
ENV WORDPRESS_DB_HOST=db \
    WORDPRESS_DB_USER=wordpress \
    WORDPRESS_DB_PASSWORD=wordpress \
    WORDPRESS_DB_NAME=wordpress

# Start the WordPress server
CMD ["apache2-foreground"]
