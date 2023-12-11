# Use an official MySQL image as the base image
FROM mysql:latest


# Expose port 3306
EXPOSE 3306

# Define the character set and collation for MySQL
RUN echo 'character-set-server=utf8mb4' >> /etc/mysql/my.cnf
RUN echo 'collation-server=utf8mb4_general_ci' >> /etc/mysql/my.cnf
