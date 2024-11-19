# Use CentOS as the base image
FROM centos:latest

# Add maintainer information
LABEL maintainer="vivekbari16@gmail.com"

# Install required packages and clean up cache
RUN yum install -y httpd zip unzip curl && \
    yum clean all && \
    rm -rf /var/cache/yum

# Download and verify the template file
WORKDIR /var/www/html/
RUN curl -O https://www.free-css.com/assets/files/free-css-templates/download/page296/spering.zip && \
    unzip spering.zip && \
    mv spering/* . && \
    rm -rf spering spering.zip

# Expose port 80 for HTTP traffic
EXPOSE 80 

# Healthcheck to ensure the HTTP server is running
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD curl -f http://localhost:80 || exit 1

# Command to start the Apache server
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
