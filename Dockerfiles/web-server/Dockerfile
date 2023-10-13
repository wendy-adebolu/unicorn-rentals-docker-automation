# Use an official WordPress image as the base image
FROM wordpress:latest

# Set environment variables for WordPress
ENV WORDPRESS_DB_HOST=db \
    WORDPRESS_DB_USER=root \
    WORDPRESS_DB_PASSWORD=password

# Copy custom themes or plugins 
RUN set -ex; \
    \
    mv /usr/local/bin/actions.mk /usr/local/bin/wordpress-php.mk; \
    mkdir -p /usr/src/wordpress/; \
	chown -R wodby:wodby /usr/src/wordpress/; \
	\
	cd /tmp; \
	wget -O wp.tar.gz "https://wordpress.org/wordpress-latest.tar.gz"; \
    su-exec wodby tar zxf /tmp/wp.tar.gz --no-same-owner --strip-components=1 -C /usr/src/wordpress; \
    rm -rf /tmp/wp.tar.gz; \
    \
    cd /usr/src/wordpress; \
	su-exec wodby mkdir -p wp-content/uploads; \
	\
	chown :www-data \
        wp-content/ \
        wp-content/uploads \
        wp-content/plugins \
        wp-content/themes; \
    \
	chmod 775 \
	    wp-content/ \
	    wp-content/uploads \
	    wp-content/plugins \
	    wp-content/themes; \
	\
	find wp-content/plugins -type d -exec chown -R :www-data {} \; -exec chmod -R 775 {} \;; \
	find wp-content/themes -type d -exec chown -R :www-data {} \; -exec chmod -R 775 {} \;; \


# Expose port 80
EXPOSE 80

# Start the WordPress server
CMD ["apache2-foreground"]
