# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'securerandom'

$NO_NODES = 2

def node_ip(i)
  "192.168.33.#{10+i}"
end

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/focal64"
  config.vm.box_check_update = true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
  end

  config.vm.provision "shell", path: "common.sh"

  # Generate a token to authenticate hosts joining the cluster
  cluster_token = "#{SecureRandom.hex(3)}.#{SecureRandom.hex(8)}"

  # Kubernetes hosts (host 0 is master)
  (0..$NO_NODES).each do |i|
    config.vm.define "host#{i}" do |host|
      host.vm.network "forwarded_port", guest: 8001, host: (8001 + i)
      host.vm.network "private_network", ip: node_ip(i)
      host.vm.hostname = "host#{i}"

      if (i == 0) then
        host.vm.provision "shell", path: "master_setup.sh", env: {"CLUSTER_TOKEN" => cluster_token, "IP_ADDRESS" => node_ip(0)}
      else
        host.vm.provision "shell", path: "node_setup.sh", env: {"NODE_NUMBER" => i, "CLUSTER_TOKEN" => cluster_token, "MASTER_ADDRESS" => node_ip(0)}
      end
    end
  end

end
