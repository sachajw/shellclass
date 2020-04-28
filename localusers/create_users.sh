#!/bin/bash

# This script creates user accounts.

if [[ "${UID}" -ne 0 ]]
then 
  echo 'Please run as sudo or root.' >&2
  exit 1
fi

for USER in carrief markh harrisonf alecg peterm
do
  useradd ${USER}
  echo 'pass123' | passwd --stdin ${USER}
done

