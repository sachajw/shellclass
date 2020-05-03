#!/bin/bash

# The script installs apache web server
# The script assumes the user running the script has sudo priviledges

usage () {
    # Display the usage and exit
    echo "Usage: ${0} HOST [HOSTN...]" >&2
    exit 1
}

# Make sure the script is not being executed with superuser privileges.
if [[ "${UID}" -eq 0 ]]
then
    echo 'Do not execute this script as root.' >&2
    usage
fi

# If the user doesn't supply at least one argument, give them help.
if [[ "${#}" -lt 1 ]]
then
    usage
fi

# Expect the best prepare for the worst
EXIT_STATUS='0'

for SERVER in "${@}"
do
    echo "Starting installation process on: ${SERVER}"

    # Ping the server to make sure it's up.
    ping -c 1 ${SERVER} &> /dev/null

    if [[ "${?}" -ne 0 ]]
    then
        echo "${SERVER} down."
        EXIT_STATUS='1'
        continue
    fi

# Install the httpd package
ssh ${SERVER} sudo yum -y install httpd

# Create an index.html file.
ssh ${SERVER} 'echo "${HOSTNAME}" | sudo tee /var/www/html/index.html &>/dev/null'

# Start httpd
ssh ${SERVER} sudo systemctl start httpd

# Enable httpd on boot
ssh ${SERVER} sudo systemctl enable httpd

# Test that the web server is accessible.
curl http://${SERVER}

if [[ "${?}" -ne 0 ]]
then
    echo "Could not access the web server on ${SERVER}." >&2
    EXIT_STATUS='1'
fi

    echo "Finished the installation process on: ${SERVER}"
done

exit ${EXIT_STATUS}
