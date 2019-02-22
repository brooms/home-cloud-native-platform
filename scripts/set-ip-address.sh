#!/usr/bin/env bash

ip_addr="192.168.1.113"
interface="eth0"

ip add add ${ip_addr}/24 dev ${interface}

