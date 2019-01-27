datacenter = "dc1"

# use /tmp to support Docker for Mac
data_dir = "/var.lib/nomad"

# bind to $host instead of default (0.0.0.0 prod, 127.0.0.1 dev)
bind_addr = "$host"

# use external adapter as the network_interface
client {  
  enabled = true
  network_interface = "$adapter"
  options {
    "driver.raw_exec.enable" = "1"
  }
}

# single server that is self-bootstrapped
server {  
  enabled = true
  bootstrap_expect = 1
}

# use the external adapter since consul should be there
consul {  
  address = "$host:8500"
}
