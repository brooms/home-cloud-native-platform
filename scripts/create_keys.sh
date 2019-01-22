#!/usr/bin/env bash

# see https://www.ssh.com/ssh/keygen for details
ALGORITHM="rsa" # one of rsa, dsa, ecdsa, ed25519
KEY_SIZE="4096"
COMMENT="rpi-home-network"
FILE="id_${ALGORITHM}_test"
DIR="~/.ssh"

ssh-keygen -t ${ALGORITHM} -b ${KEY_SIZE} -C ${COMMENT} -f ${DIR}/${FILE}
