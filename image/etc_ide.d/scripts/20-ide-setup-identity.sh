#!/bin/bash -e

###########################################################################
# This file ensures files are mapped from ide_identity into ide_home.
# Fails if any required secret or configuration file is missing.
###########################################################################

# obligatory directory, copy it with all the secrets, particulary id_rsa
if [ ! -d "${ide_identity}/.ssh" ]; then
  echo "${ide_identity}/.ssh does not exist. You won't be able to git clone over ssh"
fi
if [ ! -f "${ide_identity}/.ssh/id_rsa" ]; then
  echo "${ide_identity}/.ssh/id_rsa does not exist. You won't be able to git clone over ssh"
fi
cp -r "${ide_identity}/.ssh" "${ide_home}"

# we need to ensure that ${ide_home}/.ssh/config contains at least:
# StrictHostKeyChecking no
echo "StrictHostKeyChecking no
UserKnownHostsFile /dev/null
" > "${ide_home}/.ssh/config"
