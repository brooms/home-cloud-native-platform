#!/usr/bin/env bash

# default values
extension="yml"
inventory="hosts"
playbook="hcnp"
use_retry=false
use_sudo=false
verbose_arg="v"

while getopts "bhl:rv:" opt ;
do
  case $opt in
    b) use_sudo=true;;
    l) limit_arg=$OPTARG;;
    r) use_retry=true;;
    v) verbose_arg="-$OPTARG"
       echo "Verbose level set to ${verbose_arg}";;
    h) usage
    exit 0;;
    *) usage
    exit 1;;
  esac
done

read -p "Enter inventory file name [${inventory}]: " inventory_input
inventory="${inventory_input:-${inventory}}"
inventory_file="${inventory}.${extension}"
if [ ! -f "${inventory_file}" ] ;
then
  echo "Inventory file ${inventory_file} not found"
  exit
fi

read -p "Enter playbook file name [${playbook}]: " playbook_input
playbook="${playbook_input:-${playbook}}"
playbook_file="${playbook}.${extension}"
if [ ! -f "${playbook_file}" ] ;
then
  echo "Playbook file ${playbook_file} not found"
  exit
fi

if [ "${use_retry}" = true ] ;
then
  retry_file="${playbook}.retry"
  if [ -f ${retry_file} ] ;
  then
    echo "Will retry with file ${retry_file}"
    limits="--limit @${retry_file}"
  else
    echo "Retry file ${retry_file} not found"
    exit
  fi
fi

options=""
if [ "${use_sudo}" = true ] ;
then
  options="${options} --ask-become-pass"
fi


echo "Running playbook ${playbook_file} with inventory ${inventory_file} with options ${options}"
ansible-playbook -i ${inventory_file} ${options} ${verbose_arg} ${playbook_file} ${limits}
