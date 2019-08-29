# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

# Load settings from vagrant.yml or vagrant.yml.dist
current_dir = File.dirname(File.expand_path(__FILE__))
if File.file?("#{current_dir}/vagrant.yml")
  config_file = YAML.load_file("#{current_dir}/vagrant.yml")
elsif
  config_file = YAML.load_file("#{current_dir}/vagrant.yml.dist")
else
  exit(1)
end

base_settings = config_file['configs'][config_file['configs']['use']]
ansible_node_settings = config_file['ansible_node']
hcnp_node_settings = config_file['hcnp_node']
gateway_node_settings = config_file['gateway_node']
dns_node_settings = config_file['dns_node']

puts "%s" % base_settings

# define scripts
def generate_node_ip(base_settings, id)
  node_ip_range = base_settings['ip_range']
  node_ip_id = Integer(id)
  node_ip = [ node_ip_range, node_ip_id ].join('.')
end

def createNodes(config, ansible_node_settings, base_settings, hcnp_node_settings)

  # Set up hcnp_compute_nodes
  (1..base_settings['hcnp_node_count']).each do |i|

    hcnp_node_ip_base = Integer(hcnp_node_settings['external_ip_base']) + (i-1)
    hcnp_node_ip = generate_node_ip(base_settings, hcnp_node_ip_base)
    hcnp_node_name = hcnp_node_settings['name'] + "-" + String(i)

    puts "Node name set to %s" % hcnp_node_name
    puts "Node IP address set to %s" % hcnp_node_ip

    config.vm.define hcnp_node_name do |hcnp_node|

      service_node.vm.post_up_message = "Service node spun up!"

      service_node.vm.provider "virtualbox" do |vb|
      
        hcnp_node.vm.box = "ubuntu/xenial64"
        hcnp_node.vm.network hcnp_node_settings['external_network'], ip: hcnp_node_ip#, netmask: base_settings['external_netmask']
        hcnp_node.vm.hostname = hcnp_node_name

        vb.name = hcnp_node_name
        vb.memory = ansible_node_settings['memory']
        vb.cpus = ansible_node_settings['cpus']
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        # Enable NAT hosts DNS resolver
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

      end

      service_node.vm.provider "azure" do |azure, override|
        
        azure.vm_name = service_node_name
        azure.vm_size = 'Standard_DS2_v2'
        azure.vm_image_urn = 'canonical:ubuntuserver:16.04-LTS:latest'
      
      end

    end

  end

end

def createAnsibleNode(config, ansible_node_settings, base_settings)

  # Create a machine to run ansible
  ansible_node_ip_base = Integer(ansible_node_settings['external_ip_base'])
  ansible_node_ip = generate_node_ip(base_settings, ansible_node_ip_base)
  ansible_node_name = ansible_node_settings['name']

  config.vm.define ansible_node_name do |ansible_node|

    ansible_node.vm.post_up_message = "Ansible node spun up!"

    ansible_node.vm.provider "virtualbox" do |vb|

      ansible_node.vm.box = "ubuntu/xenial64"
      ansible_node.vm.network ansible_node_settings['external_network'], ip: ansible_node_ip, netmask: base_settings["external_netmask"]
      # ansible_node.vm.network "private_network", ip: "172.16.1.1", netmask: "255.255.255.0"
      
      vb.name = ansible_node_name
      vb.memory = ansible_node_settings['memory']
      vb.cpus = ansible_node_settings['cpus']
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      # Enable NAT hosts DNS resolver
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

      ansible_node.vm.provision :ansible_local do |ansible|

        ansible_node.vm.synced_folder ".", "/vagrant",
          owner: "vagrant",
          mount_options: ["dmode=775,fmode=600"]

        ansible.compatibility_mode = "2.0"
        ansible.install = true
        ansible.limit = "all"
        ansible.verbose = "v"

        ansible.config_file = "ansible/ansible.cfg"
        ansible.inventory_path = "hosts-vagrant.yml"
        ansible.playbook = "ansible/hcnp.yml"

        ansible.galaxy_role_file = "ansible/requirements.yml"
        ansible.galaxy_roles_path = "ansible/roles"

        ansible.extra_vars = {}
      end
    
    end

    service_node.vm.provider "azure" do |azure, override|
      
      azure.vm_name = service_node_name
      azure.vm_size = 'Standard_DS2_v2'
      azure.vm_image_urn = 'canonical:ubuntuserver:16.04-LTS:latest'
    
      ansible_node.vm.provision :ansible_local do |ansible, override|

        ansible.compatibility_mode = "2.0"
        ansible.install = true
        ansible.limit = "all"
        ansible.verbose = "v"

        ansible.config_file = "ansible/ansible.cfg"
        ansible.inventory_path = "hosts-vagrant.yml"
        ansible.playbook = "ansible/hcnp.yml"

        ansible.galaxy_role_file = "ansible/requirements.yml"
        ansible.galaxy_roles_path = "ansible/roles"

        ansible.extra_vars = {}
      end

    end

  end

end

def createGatewayNode(config, ansible_node_settings, base_settings, gateway_node_settings)

  gateway_node_ip_base = Integer(gateway_node_settings['external_ip_base'])
  gateway_node_ip = generate_node_ip(base_settings, gateway_node_ip_base)
  gateway_node_name = gateway_node_settings['name']

  config.vm.define gateway_node_name do |gateway_node|

    gateway_node.vm.post_up_message = "Gateway node spun up!"

    gateway_node.vm.provider "virtualbox" do |vb|

      gateway_node.vm.box = "debian/jessie64"
      gateway_node.vm.network ansible_node_settings['external_network'], ip: gateway_node_ip, netmask: base_settings["external_netmask"]
      
      vb.name = gateway_node_name
      vb.memory = gateway_node_settings['memory']
      vb.cpus = gateway_node_settings['cpus']
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      # Enable NAT hosts DNS resolver
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

    end

    service_node.vm.provider "azure" do |azure, override|
        
      azure.vm_name = service_node_name
      azure.vm_size = 'Standard_DS2_v2'
      azure.vm_image_urn = 'canonical:ubuntuserver:16.04-LTS:latest'
      
    end

  end

end

def createDNSNode(config, ansible_node_settings, base_settings, dns_node_settings)

  dns_node_ip_base = Integer(dns_node_settings['external_ip_base'])
  dns_node_ip = generate_node_ip(base_settings, dns_node_ip_base)
  dns_node_name = dns_node_settings['name']

  config.vm.define dns_node_name do |dns_node|

    dns_node.vm.post_up_message = "DNS node spun up!"

    dns_node.vm.provider "virtualbox" do |vb|

      dns_node.vm.box = "debian/jessie64"
      dns_node.vm.network ansible_node_settings['external_network'], ip: dns_node_ip, netmask: base_settings["external_netmask"]

      vb.name = dns_node_name
      vb.memory = dns_node_settings['memory']
      vb.cpus = dns_node_settings['cpus']
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      # Enable NAT hosts DNS resolver
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

    end

    service_node.vm.provider "azure" do |azure, override|
        
      azure.vm_name = service_node_name
      azure.vm_size = 'Standard_DS2_v2'
      azure.vm_image_urn = 'canonical:ubuntuserver:16.04-LTS:latest'
    
    end

  end

end

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  # if ARGV[1] == 'test'
  #   ARGV.delete_at(1)
  #   test = true
  # else
  #   test = false
  # end

  # Specify provider order preference
  config.vm.provider "virtualbox"
  config.vm.provider "azure"

  # Set virtualbox provider specific attributes
  config.vm.provider "virtualbox" do |v|
    # config.vm.box = "ubuntu/xenial64"
    v.gui = false
  end

  # Set azure provider specific attributes
  config.vm.provider "azure" do |az, override|

    override.vm.box = 'azure'
    
    if not Vagrant::Util::Platform.windows? then
      # use local ssh key to connect to remote vagrant box
      config.ssh.private_key_path = '~/.ssh/id_rsa'
    end
    # Pull Azure AD service principal information from environment variables
    az.tenant_id = ENV['AZURE_TENANT_ID']
    az.client_id = ENV['AZURE_CLIENT_ID']
    az.client_secret = ENV['AZURE_CLIENT_SECRET']
    az.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']
    # Set other Azure attributes
    az.location = 'australiaeast'
    az.resource_group_name = 'ccic-dev'     
  end

  config.vm.provider "hyperv" do |h, override|
    override.vm.box = ""
    h.enable_virtualization_extensions = true
    h.linked_clone = true
  end

  createNodes(config, ansible_node_settings, base_settings, hcnp_node_settings)

  createDNSNode(config, ansible_node_settings, base_settings, dns_node_settings)

  createGatewayNode(config, ansible_node_settings, base_settings, gateway_node_settings)

  createAnsibleNode(config, ansible_node_settings, base_settings)

end
