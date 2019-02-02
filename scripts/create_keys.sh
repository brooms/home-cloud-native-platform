#!/usr/bin/env bash

# see https://www.ssh.com/ssh/keygen for details
key_algorithm="rsa" # one of rsa, dsa, ecdsa, ed25519
key_size="4096"
key_comment="home-cloud-native-platform"
key_file="id_${ALGORITHM}_hcnp"
key_file_dir="${HOME}/.ssh"

if [ -f ${key_file_dir}/${key_file} ] ; then
  echo "key file ${key_file_dir}/${key_file} already exists"
  exit
else
  echo "generating key file ${key_file_dir}/${key_file} using ${key_algorithm} algorithm with size ${key_size}"
  ssh-keygen -t ${key_algorithm} -b ${key_size} -C ${key_comment} -f ${key_file_dir}/${key_file}
fi
