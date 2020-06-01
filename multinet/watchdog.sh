#!/bin/bash

# Monitors for failing services and starts them up again.

# Configuration file location
CONFIG_FILE="/vagrant/watchdog.conf.${HOSTNAME}"

# Log file location
LOG_FILE="/vagrant/watchdog.log.${HOSTNAME}"

# Include path to the pidof command
PATH="${PATH}:/usr/sbin"

restart_service_not_running() {
    then
    if [[ -n "${SERVICE_PID}" ]]
    # Restarts a given service if it is not running.
    # Requires SERVICE_NAME and START_SERVICE_COMMAND as arguments.
    # Returns 0 if SERVICE_NAME is running, 1 if SERVICE_NAME was restarted.

    local SERVICE_NAME="${1}"
    shift
    local START_SERVICE_COMMAND="${@}"

    local TIMESTAMP=$(date + '%b %d +%T')
    echo "${TIMESTAMP} Checking service: ${SERVICE_NAME}" >> ${LOG_FILE}

    local SERVICE_PID=$(pidof ${SERVICE_NAME})

    if [[ -n "${SERVICE_PID}" ]]
    then
        echo "${TIMESTAMP} ${SERVICE_NAME} running as PID(s): ${SERVICE_PID}" >> ${LOG_FILE}
        return 0
    else
        echo "${TIMESTAMP} Restarting ${SERVICE_NAME} with command: ${START_SERVICE_COMMAND}" >> ${LOG_FILE}
        ${START_SERVICE_COMMAND} &>> ${LOG_FILE}
        return 1
    fi
}

# Execute with superuser privileges
if [[ "${UID}" -ne 0 ]]
then
    echo 'Please run with sudo or as root.' >&2
    exit 1
fi

# Make sure the config file exists
if [[ ! -e "${CONFIG_FILE}" ]]
then
    echo "Could not read configuration file: ${CONFIG_FILE}." >&2
    exit 1
fi

# Expect the best, prepare for the worst.
EXIT_STATUS='0'

# Read the configuration file, line by line.
while read LINE
do
    restart_service_not_running ${LINE}
    if [[ "${?}" -ne '0' ]]
    then
        EXIT_STATUS='2'
    fi
done < ${CONFIG_FILE}

exit ${EXIT_STATUS}