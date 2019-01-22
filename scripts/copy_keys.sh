#!/usr/bin/env bash

FILE="id_rsa_hcnp"
DIR="${HOME}/.ssh"
REMOTE_USER=${USER}

echo "Enter remote host name:"
read remote_host

echo "Enter remote user:"
read remote_user


if [ -f ${DIR}/${FILE} ] ; then
  ssh-copy-id -i ${DIR}/${FILE} ${remote_user}@${remote_host}
else
  echo "ssh key file ${DIR}/${FILE} not found!"
fi
