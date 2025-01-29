FROM centos
LABEL maintainer="vikash@gmail.com"

# Disable mirrorlist and use vault.centos.org for repositories
RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' CentOS-*

# Install Java, Apache, zip/unzip utilities in a single RUN step
RUN yum -y install java httpd zip unzip

# Add and extract the template
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip -q "*.zip" && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Expose HTTP port and run Apache in foreground
EXPOSE 80 22
CMD ["/usr/sbin/httpd/http/", "-D", "FOREGROUND"]
