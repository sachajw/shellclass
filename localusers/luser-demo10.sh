#!/bin/bash

# This script demonstrates functions.

# call a function this way and you don't need the elipses
#function log {
#  echo 'You called the log function!'
#}
#
#log

# call a function this way and you need the elipses
#log () {
#  local MESSAGE="${@}"
#  if [[ "${VERBOSE}" = 'true' ]]
#  then
    echo "${MESSAGE}"
#  fi
#}
#
#log 'Hello!'
#VERBOSE='true'
#log 'This is fun!'
#
# global variables - avoid the problems of global variables - such as functions changing global variables
#log () {
#  local VERBOSE="${1}"
#  shift
#  local MESSAGE="${@}"
#  if [[ "${VERBOSE}" = 'true' ]]
#  then
#    echo "${MESSAGE}"
#  fi
#}
#
#VERBOSITY='true'
#log "${VERBOSITY}" 'Hello!'
#log "${VERBOSITY}" 'This is fun!'

# Function & global variables
log () {
  # This function sends a message to syslog and to standard output if VERBOSE is true.
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
  logger -t luser-demo10.sh "${MESSAGE}"
}

backup_file() {
  # This function creates a backup of a file. Returns non-zero status on error.

  local FILE="${1}"

  # Make sure the file exists.
  if [[ -f "${FILE}" ]]
  then
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    log "Backing up ${FILE} to ${BACKUP_FILE}."

    # The exit status of the function will be the exit status of the cp command.
    cp -p ${FILE} ${BACKUP_FILE} # -p preserves file mode, ownership and timestamp
  else
    # The file does not exist, so return a non-zero exit status.
    return 1
  fi
}

readonly VERBOSE='true' # readonly makes the variable unmodifieable - elements the concern of changing a global variable
log 'Hello!'
log 'This is fun!'

backup_file '/etc/passwd'

# Make a decision based on the exit status of the function.
if [[ "${?}" -eq '0' ]]
then
  log 'File backup succeeded!'
else 
  log 'File backup failed!'
  exit 1 # exit exits the entire function not just the script whereas return is just for the function
fi




