#!/bin/bash

# This script deletes, disables & archives user accounts.

ARCHIVE_DIR='/archive'

usage() {
  # Display the usage and exit.
  echo "Usage: ${0} [dra] USER [USERN]..." >&2
  echo 'Disable a local Linux account.' >&2
  echo -d 'Deletes the user account.' >&2
  echo -r 'Removes the user home directory.' >&2
  echo -a 'Archives the user home directory.' >&2
  
  exit 1
}

# Run the script as root.
if [[ "${UID}" -ne 0 ]]
then
  echo 'Please run with sudo or as root.' >&2
  exit 1
fi
 
# Setup the options.
while getopts dra OPTION
do
  case ${OPTION} in
    d) DELETE_USER='true' ;;
    r) REMOVE_HOME_DIR='-r' ;;
    a) ARCHIVE='true' ;;
    ?) usage ;;
  esac
done

# Remove the options leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"

# If the user does not supply at least one argument, give them help.
if [[ "${#}" -lt 1 ]]
then
  usage
fi

# Loop through all lthe usernames supplied as arguments.
for USERNAME in "${@}"
do
  echo "Baking a user: ${USERNAME}"

  # Make sure the UID of the account is at least 1000.
  USERID=$(id -u ${USERNAME})
  if [[ "${USERID}" -lt 1000 ]]
  then
    echo "Computer says no to removing the ${USERNAME} acccount with UID ${USERID}." >&2
    exit 1
  fi

# Create an archive.
if [[ "${ARCHIVE}" = 'true' ]]
then
  # Make sure ARCHIVE_DIR exists.
  if [[ ! -d "${ARCHIVE_DIR}" ]]
  then
    echo "Creating ${ARCHIVE_DIR} directory."
    mkdir -p ${ARCHIVE_DIR}
    if [[ "${?}" -ne 0 ]]
    then
      echo "The archive directory ${ARCHIVE_DIR} could not be created." >&2
      exit 1
    fi
  fi

# Archive the user's home directory and move it to ARCHIVE_DIR.
    HOME_DIR="/home/${USERNAME}"
    ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
    if [[ -d "${HOME_DIR}" ]]
    then
      echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
      tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
      if [[ "${?}" -ne 0 ]]
      then
        echo "Could not create ${ARCHIVE_FILE}." >&2
        exit 1
      fi
    else
      echo "${HOME_DIR} does not exist or is not a directory." >&2
      exit 1
    fi
  fi

  if [[ "${DELETE_USER}" = 'true' ]]
  then
    # Delete the user
    userdel ${REMOVE_HOME_DIR} ${USERNAME}
  
    # Check that userdel executed successfully.
    if [[ "${?}" -ne 0 ]]
    then
      echo "The account ${USERNAME} was NOT deleted." >&2
      exit 1
    fi
    echo "The account ${USERNAME} was deleted." 
  else 
    chage -E 0 ${USERNAME}
# Check that chage executed successfully.
    if [[ "${?}" -ne 0 ]]
    then 
      echo "The account ${USERNAME} was NOT disabled." >&2
      exit 1
    fi
    echo "The account ${USERNAME} was disabled."
  fi  
done

exit 0