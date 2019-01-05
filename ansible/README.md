# Installing Ansible

See https://raspi.farm/howtos/install-ansible/

## Prerequisites

### Install Git

```base
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python3-dev libffi-dev libssl-dev
```

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

### Install pip

See https://pip.pypa.io/en/stable/installing/

<!-- Add the following to '~/.profile’ (or equivalent) file:

```bash
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
``` -->

Get pip

```bash
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
```

See https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#latest-releases-via-pip

```bash
sudo pip3 install ansible
```

<!-- python get-pip.py --user -->

### Add Python modules

```bash
pip install --user -r requirements.txt --upgrade
```

requirements:
jinja2
cryptography
yaml

### Clone Ansible repo

To ensure Ansible is the latest version install using

```bash
cd ~
git clone git://github.com/ansible/ansible.git --recursive
source ~/ansible/hacking/env-setup
```

Add the following into ‘~/.profile’ (or equivalent) file:

```bash
source ~/ansible/hacking/env-setup -q   # -q makes it silent
```

To update source code use

```bash
git pull --rebase
git submodule update --init --recursive
```


# Ansible

See https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html for Tips such as

## Playbook syntax checking

ansible-playbook playbook.yml --syntax-check

## Hosts

nsible-playbook playbook.yml --list-hosts