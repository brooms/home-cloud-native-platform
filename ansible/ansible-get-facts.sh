#!/usr/bin/env bash

echo "Enter remote host address:"
read remote_host

ansible ${remote_host} -i hosts.yml -m setup

