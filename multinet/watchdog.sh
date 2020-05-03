#!/bin/bash

# Monitors for failing services and starts them up again.

# Configuration file location
CONFIG_FILE="/vagrant/watchdong.conf.${HOSTNAME}"

# Log file location
LOG_FILE="/vagrant/watchdog.log.${HOSTNAME}"

# Include path to the pidof command
PATH="${PATH}:/usr/sbin:/sbin"




# Include path to the pidof command
# Restarts a given service if it is not running.
# Requires SERVICE_NAME and START_SERVICE_COMMAND as arguments.
# Returns 0 if SERVICE_NAME us running, 1 if SERVICE_NAME was restarted
# Make sure the script is being executed with superuser privileges.
# Make sure the config file exists.
# Expect the best, prepare for the worst.
# Read the configuration file, line by line.
