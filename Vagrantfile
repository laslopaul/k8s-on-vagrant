# -*- mode: ruby -*-
# vi: set ft=ruby :

cluster = [
  { "name" => "controller", "private_ip" => "192.168.56.10" },
  { "name" => "worker0", "private_ip" => "192.168.56.11" },
  { "name" => "worker1", "private_ip" => "192.168.56.12" },
  { "name" => "worker2", "private_ip" => "192.168.56.13" }
]

Vagrant.configure("2") do |config|

  cluster.each do |node|
    config.vm.define node['name'] do |params|
      params.vm.box = "ubuntu-k8s"
      params.vm.hostname = node['name']
      params.vm.network :private_network, ip: node['private_ip']
      params.vm.synced_folder ".", "/vagrant", disabled: true

      params.vm.provider :virtualbox do |vb|
        vb.name = node['name']
      end

    end

  end

end