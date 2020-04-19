#!/bin/bash

# Parsing cmd line options with getopts. Use shell builtins as it makes your scipts more portable

# This script generates a random password.
# This user can set the password length with -l and add a special character with -s.
# Verbose mode can be enabled with -v.

usage () {
  echo "Usage: ${0} [-vs] [-l LENGTH]" .&2
  echo 'Generate a random password.'
  echo ' -l LENGTH Specify the password length.'
  echo ' -s        Append a special charactoer to the password.'
  echo ' -v        Increase verbosity.'
  exit 1
}

log () {
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
then
  echo "${MESSAGE}"
fi
}

# Set a default password length
LENGTH=48

while getopts vl:s OPTION # -l option - means you provide the options
do
  case ${OPTION} in
    v)
      VERBOSE='true'
      log 'Verbose mode on.'
      ;;
    l)
      LENGTH="${OPTARG}"
     ;;
    s)
      USE_SPECIAL_CHARACTER='true'
      ;;
    ?)
      usage 
      ;;
      #echo 'Invalid option.' >&2
      #exit 1
esac
done 

echo 'Generating a password.'

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c ${LENGTH})

# Append a special character if requested to do so.
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
  log 'Selecting a random special character.'
  SPECIAL_CHARACTER=$(echo '!@#$%^&*()-+=' | fold -w1 | shuf | head -c1)
  PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log 'Done.'
log 'Here is the password:'

# Display the password.
echo "${PASSWORD}"

exit 0



