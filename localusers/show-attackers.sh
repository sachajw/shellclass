#!/bin/bash

# Display 10 or more failed login attempts by IP address.
LOG_FILE="${1}"
LIMIT='10'

# Make sure a file was supplied as an argument
if [[ ! -e "${LOG_FILE} " ]]
then
  echo "Cannot open log file: ${LOG_FILE}" >&2
  exit 1
fi

# Display the CSV header
echo 'Count,IP,Location'

# Loop through the list of failed attempts and corresponding IP addresses
grep Failed syslog-sample | awk '{print $(NF - 3)}' | sort | uniq -c | sort -nr | while read COUNT IP
do
  # If the number of failed attempts is greater than the limit, display count, IP, and location
  if [[ "${COUNT}" -gt "${LIMIT}" ]]
  then
    LOCATION=$(geoiplookup ${IP} | awk -F ', ' '{print $2}')
    echo "${COUNT},${IP},${LOCATION}"
  fi
done
exit 0