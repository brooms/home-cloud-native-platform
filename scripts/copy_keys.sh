#!/usr/bin/env bash

source ./key_vars.sh

remote_user=${USER}

# create an array of remote hosts
# declare -A remote_hosts

remote_hosts=(
  rpi-hcnp-node-50
  rpi-hcnp-node-53
  rpi-hcnp-node-54
  rpi-hcnp-node-55
)

read -p "Enter key file name [${key_file}]: " key_file_input
key_file=${key_file_input:-${key_file}}

read -p "Enter key file directory [${key_file_dir}]: " key_file_dir_input
key_file_dir=${key_file_dir_input:-${key_file_dir}}

read -p "Enter remote hosts [${remote_hosts}]: " remote_hosts_input
remote_hosts=${remote_hosts_input:-remote_hosts}

read -p "Enter user  for remote hosts [${remote_user}]: " remote_user_input
remote_user=${remote_user_input:-${remote_user}}

  if [ -f ${key_file_dir}/${key_file} ] ; then
    for remote_host in "${remote_hosts[@]}" ;
    do
      echo "copying key file ${key_file_dir}/${key_file} to ${remote_user}@${remote_host}"
      ssh-copy-id -i ${key_file_dir}/${key_file} ${remote_user}@${remote_host}
    done
  else
    echo "key file ${key_file_dir}/${key_file} not found!"
    exit
  fi
