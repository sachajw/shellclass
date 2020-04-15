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

# Help the user supply one argument
NUMBER_OF_PARAMETERS="${#}"
echo "You supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line."

if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [USER_NAME]..."
  exit 1
fi

# The first parameter is the user name.
 while [[ "${#}" -gt 0 ]]
 do
   #echo "Number of parameters: ${#}"
   echo "Parameter 1: ${1}"
   echo "Parameter 2: ${2}"
   echo "Parameter 3: ${3}"
   echo
done

# The remaining parameters are for the comments
 while [[ "${#}" -gt 0 ]]
 do
   echo "Number of parameters: ${#}"
   echo "Parameter 1: ${1}"
   echo "Parameter 2: ${2}"
   echo "Parameter 3: ${3}"
   echo
   shift
done

# Generate a password.
for USER_NAME in "${@}"
do
 PASSWORD=$(date +%s%N | sha256sum | head -c48)
 echo "${USER_NAME}: ${PASSWORD}"
 done 

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
echo User account credentials and hostname are the following: username: ${USER_NAME}, password: ${PASSWORD}, hostname: ${HOSTNAME}
