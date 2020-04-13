#!/bin/bash

# This script creates an account on the local system.
# You will be prompted for the account name and password.

# Make sure the script is being executed with superuser privileges
USER_NAME=$(id -un)
if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root.'
else
  echo 'You are not root.'
fi

# Ask for the user name.
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name.
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Ask for the password.
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user with the password.
useradd -c "${COMMENT}" -m ${USER_NAME} # quotes are added so that people can have spaces in their names

# Did the useradd command succeed.
if [[ "${?}" -ne 0 ]]
then
  echo 'The useradd command did not execute successfully.'
  exit 1
fi
echo "Your username is ${USER_NAME}"

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Did the password command succeed.
if [[ "${?}" -ne 0 ]]
then
  echo 'The password command did not execute successfully.'
  exit 1
fi
echo "Your password is ${PASSWORD}"

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password and host where the user was created.
HOSTNAME=$(hostname)
echo ${USER_NAME} ${PASSWORD} ${HOSTNAME}


