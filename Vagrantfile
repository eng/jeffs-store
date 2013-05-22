# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
echo 'export LC_ALL=en_US.UTF-8' > /etc/bash.bashrc
echo 'export LANG=en_US.UTF-8' > /etc/bash.bashrc
echo 'export LANGUAGE=en_US.UTF-8' > /etc/bash.bashrc
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.synced_folder "./", "/vagrant_data"
  config.vm.provision :shell, :inline => $script
end
