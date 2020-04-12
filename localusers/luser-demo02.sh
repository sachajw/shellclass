#!/bin/bash

# Display the UID and username of the user executing this script.
# Display if the user is the root user or not.

# Display the UID - preset variable
echo "Your UID is ${UID}"

# Display the username
USER_NAME=$(id -un)
#USER_NAME=`id -un` # another of way doing variables
echo "Your username is ${USER_NAME}"

# Display if the user is the root user or not 
# Root is always the UID of 0 of any unix system
# Double brackets is the new way to do if statements
if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root.'
else
  echo 'You are not root.'
fi

