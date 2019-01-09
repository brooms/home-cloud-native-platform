### Add Python modules

```bash
pip install --user -r requirements.txt --upgrade
```

requirements:
cryptography
jinja2
paramiko
PyYAML

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
