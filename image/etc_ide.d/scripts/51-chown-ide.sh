#!/bin/bash -e

###########################################################################
# This script must be run after ide linux user uid and gid are set.
# Put here any chown commands.
###########################################################################

for id_rsa_file in "${ide_home}/.ssh/"*"id_rsa"; do
  chown ide:ide "${id_rsa_file}"
  chmod 0600 "${id_rsa_file}"
done
