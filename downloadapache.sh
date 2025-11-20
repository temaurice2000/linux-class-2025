#!/bin/bash

#Download Apache 2 on Red Hat Linux terminal

# Check if the user is root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
else 
	sudo su -
fi

echo "Starting Apache installation on Red Hat Linux..."

# Check if Apache is already installed
if rpm -q httpd &>/dev/null; then
    echo "Apache (httpd) is already installed."
    echo "Skipping installation and ensuring service is enabled and running."
    systemctl enable httpd
    systemctl start httpd
else
    echo "Apache (httpd) is not installed. Proceeding with installation."
    # Install Apache
    if yum install -y httpd; then
        echo "Apache (httpd) installed successfully."
        # Enable and start Apache service
        systemctl enable httpd
        systemctl start httpd
        echo "Apache service enabled and started."
        # Open firewall ports for HTTP and HTTPS
        firewall-cmd --permanent --add-service=http
        firewall-cmd --permanent --add-service=https
        firewall-cmd --reload
        echo "Firewall configured for HTTP and HTTPS."
    else
        echo "Error: Apache (httpd) installation failed."
        exit 1
    fi
fi

echo "Apache installation and configuration script finished."


