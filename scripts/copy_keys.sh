#!/usr/bin/env bash

FILE="id_${ALGORITHM}_test"
DIR="~/.ssh"
REMOTE_USER=${USER}

echo "Enter remote host name:"
read remote_host

ssh-copy-id -i ${DIR}/${FILE} ${USER}@${remote_host}
