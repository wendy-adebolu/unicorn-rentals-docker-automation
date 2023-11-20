# Use an official MySQL image as the base image
FROM mysql:latest

# Set environment variables for MySQL
# Note: Update these values with your actual database configuration
ENV MYSQL_ROOT_PASSWORD=root_password \
    MYSQL_DATABASE=wordpress \
    MYSQL_USER=wordpress \
    MYSQL_PASSWORD=wordpress

# Expose port 3306
EXPOSE 3306

# Define the character set and collation for MySQL
RUN echo 'character-set-server=utf8mb4' >> /etc/mysql/my.cnf
RUN echo 'collation-server=utf8mb4_general_ci' >> /etc/mysql/my.cnf
