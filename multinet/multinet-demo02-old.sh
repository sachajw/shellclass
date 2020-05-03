#!/bin/bash

# This script installs the apache web server.

# Make sure the script is being executed with superuser priviledges
if [[ "${UID}" -ne 0 ]]
then
    echo 'Please run with sudo or root priviledges.' >&2
    exit 1
fi

# Install apache
yum install -y httpd

# Put an index.html file the document root
echo 'Hello world!' > /var/www/html/index.html

# Start apache
systemctl start httpd

# Make sure apache starts on boot
systemctl enable httpd

# Installation done!
exit 0
