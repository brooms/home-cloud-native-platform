#!/usr/bin/env bash

# install external roles
ansible-galaxy install -r requirements.yml -p roles/

# run playbook
# ansible-playbook -vv --ask-become-pass development-system.yml
