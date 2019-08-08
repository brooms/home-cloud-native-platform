# Home Cloud Native Platform

Infrastucture-as-code scripts to provision multiple services to support home automation on either networked virtual nodes or hardware nodes. The services installed allow provisioning on hardware such as [Raspberry Pis](https://www.raspberrypi.org/) to Intel x64 based machines. The scipts utilise [Hashicorp Vagrant](https://vagrant.io) to provision on etither VirtualBox or Azure Virtual Machines, and [Ansible](https://www.ansible.com/) to provision the nodes.

The following core services are installed on each node:

* [Docker](https://www.docker.com/) for running containerised services.
* [Hashicorp Consul](https://www.consul.io/) for service registration and discovery.
* [Hashicorp Vault](https://www.hashicorp.com/products/vault/) for managing secrets.
* [Hashicorp Nomad](https://www.hashicorp.com/products/nomad) for orchestrating services.
* [Traefik](https://traefik.io/) as a reverse proxy and gateway.

## Dependencies

[Hashicorp Vagrant](https://vagrant.io) is required to be installed on the machine from which the scripts are run in order to provision virtual nodes.

## Installing

### Virtual Nodes through Vagrant

#### Azure

Requires the Vagrant Azure plugin from https://github.com/Azure/vagrant-azure. [Install the plugin](https://www.vagrantup.com/docs/plugins/usage.html) using

```bash
vagrant plugin install vagrant-azure
```

```bash
 vagrant box add azure https://github.com/azure/vagrant-azure/raw/v2.0/dummy.box --provider azure
$ vagrant plugin install vagrant-azure
$ vagrant up --provider=azure
```

#### Virtualbox


### Physical Nodes

Create an ssh key using [`scripts/create_keys.sh`](scripts/create_keys.sh) and copy is across to the nodes using [`scripts/copy_keys.sh`](scripts/copy_keys.sh).

Ensure Ansible is installed on the controller using [`scripts/install_ansible.sh`](scripts/install_ansible.sh).

Copy the example [Ansible Inventory](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html), [`ansible/hosts-example.yml`](ansible/hosts.yml), to `ansible/hosts.yml` and configure with the IP addresses of the nodes. to suit the network. Check the nodes specified within the inventory file using [`ansible/ansible-list-all-nodes.sh`](ansible/ansible-list-all-nodes.sh). Test the connection to the nodes using [`ansible/ansible-ping-all-nodes.sh`](ansible/ansible-ping-all-nodes.sh). Get the facts about a node using [`ansible/ansible-get-facts.sh`](ansible/ansible-get-facts.sh).

Create an [Ansible Playbook](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html) to run required roles on specified hosts. Test the playbook syntax using [`ansible/ansible-check-playbook-syntax.sh`](ansible/ansible-check-playbook-syntax.sh). Run the Ansible playbook using [`ansible/ansible-run-play.sh`](ansible/ansible-run-play.sh).

### Playbooks

* [`hcnp.yml`](hcnp.yml) will provision a node with a base OS with the core services defined above.
