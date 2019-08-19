#!/usr/bin/env bash

# see https://www.ssh.com/ssh/keygen for details
export key_algorithm="rsa" # one of rsa, dsa, ecdsa, ed25519
export key_size="4096"
export key_comment="hcnp"
export key_file="id_${key_algorithm}_hcnp"
export key_file_dir="${HOME}/.ssh"
