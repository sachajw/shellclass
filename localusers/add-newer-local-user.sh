#!/bin/bash

# This script creates an account on the local system.
# You must supply a username as an argument to the script.
# Provide a optional comment for the account as an argument
# The password will be automatically generated for the account
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges
USER_NAME=$(id -un)
if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root.'
else
  echo 'You are not root.' >&2 
fi

# Help the user supply one argument
if [[ "${#}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [COMMENT]..." >&2
  echo 'Create a local system account wth USER_NAME and a comments field of COMMENT.' >&2
  exit 1
fi

# The first parameter is the user name.
 USER_NAME="${1}"

# The remaining parameters are for the comments
shift
COMMENT="${@}"

# Generate a password.
PASSWORD=$(date +%s%N${RANDOM}${RANDOM}${RANDOM} | sha256sum | head -c64)

# Create the user with the password.
useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null 
# quotes are added so that people can have spaces in their names 
# all output sent to dev null so nothing is displayed to the screen 

# Did the useradd command succeed.
if [[ "${?}" -ne 0 ]]
then
  echo 'The user account was not created successfully.' &>2
  exit 1
fi
echo "Your username is ${USER_NAME}"

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null

# Did the password command succeed.
if [[ "${?}" -ne 0 ]]
then
  echo 'The password was not successfully created.' &>2
  exit 1
fi
echo "Your password is ${PASSWORD}"

# Force password change on first login.
passwd -e ${USER_NAME} &> /dev/null

# Display the username, password and host where the user was created.
HOSTNAME=$(hostname)
echo User account credentials and hostname are the following: 
echo 'username:' ${USER_NAME}
echo 
echo 'password:' ${PASSWORD}
echo 
echo 'hostname:' ${HOSTNAME}
exit 0 