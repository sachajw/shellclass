#!/bin/bash

# This script demonstrates the case statement.

#if [[ "${1}" = 'start' ]]
#then
#  echo 'Starting'
#elif [[ "${1}" = 'stop' ]]
#then
#  echo 'Stopping'
#elif [[ "${1}" = 'status' ]]
#then
#  echo 'Status:'
#else 
#  echo 'Supply a valid option' >&2
#  exit 1
#fi
# this case statement is the bases for most init.d services
#case "${1}" in
#  start)
#    echo 'Starting'
#    ;;
#  stop)
#    echo 'Stopping'
#    ;;
#  status|state|--status|--state) # pipe can also be referred to as an OR statement
#    echo 'Status'
#    ;;
#  *)
#    echo 'Supplay a valid option' >&2
#    ;;
#esac

case "${1}" in
  start) echo 'Starting' ;;
  stop) echo 'Stopping' ;;
  status) echo 'Status' ;;
  *)
    echo 'Supplay a valid option' >&2
    exit 1
    ;;
esac



