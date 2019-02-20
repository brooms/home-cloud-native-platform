# Home Cloud Native Platform

Set of [Ansible](https://www.ansible.com/) scripts to automatically configure a set of [Raspberry Pis](https://www.raspberrypi.org/) to host multiple service to support home automation.

The following core services are installed on each host:

* [Hashicorp Consul](https://www.consul.io/)
* [Hashicorp Vault](https://www.hashicorp.com/products/vault/)
* [Hashicorp Nomad](https://www.hashicorp.com/products/nomad)
* [Docker](https://www.docker.com/)
* [Cadvisor](https://github.com/google/cadvisor)


The following services are distributed across the nodes:

* [Portainer](https://www.portainer.io/)
* [Mosquitto MQTT Broker](https://mosquitto.org/)
* [openHAB](https://www.openhab.org/)
* [Radicale](https://radicale.org/)
* [Home Assistant](https://www.home-assistant.io/)
* [Nextcloud](https://nextcloud.com/)
* [Kerberos.io](https://www.kerberos.io/)
