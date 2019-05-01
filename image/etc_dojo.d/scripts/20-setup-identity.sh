#!/bin/bash -e

###########################################################################
# This file ensures files are mapped from dojo_identity into dojo_home.
# Fails if any required secret or configuration file is missing.
###########################################################################

# obligatory directory, copy it with all the secrets, particulary id_rsa
if [ ! -d "${dojo_identity}/.ssh" ]; then
  echo "${dojo_identity}/.ssh does not exist. You won't be able to git clone over ssh"
fi
if [ ! -f "${dojo_identity}/.ssh/id_rsa" ]; then
  echo "${dojo_identity}/.ssh/id_rsa does not exist. You won't be able to git clone over ssh"
fi
cp -r "${dojo_identity}/.ssh" "${dojo_home}"

# we need to ensure that ${dojo_home}/.ssh/config contains at least:
# StrictHostKeyChecking no
echo "StrictHostKeyChecking no
UserKnownHostsFile /dev/null
" > "${dojo_home}/.ssh/config"

chown -R dojo:dojo "${dojo_home}/.ssh"
