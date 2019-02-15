#!/usr/bin/env bash

# uncomment following line to use sudu
use_sudo=true

inventory="hosts.yml"
playbook="common.yml"

read -p "Enter inventory file name [${inventory}]: " inventory_input
inventory=${inventory_input:-${inventory}}

read -p "Enter playbook file name [${playbook}]: " playbook_input
playbook=${playbook_input:-${playbook}}

options=""
if [ ! -z ${use_sudo+x} ] ; then
  options="${options} --ask-become-pass"
fi

if [ -f ${inventory} ] && [ -f ${playbook} ] ; then
  echo "Running playbook ${playbook} with inventory ${inventory}"
  ansible-playbook -i ${inventory} ${options} ${playbook}""
else
  echo "Check inventory and playbook files"
  exit
fi
