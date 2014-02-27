# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
echo 'export LC_ALL=en_US.UTF-8' >> /etc/bash.bashrc
echo 'export LANG=en_US.UTF-8' >> /etc/bash.bashrc
echo 'export LANGUAGE=en_US.UTF-8' >> /etc/bash.bashrc
echo 'export RAILS_ENV=production' >> /etc/bash.bashrc
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.define :precise32 do |precise_config|
    precise_config.vm.box = "precise32"
    precise_config.vm.network :private_network, ip: "192.168.33.10"
    precise_config.vm.synced_folder "./", "/vagrant_data"
    precise_config.vm.provision :shell, :inline => $script
  end

  config.vm.define :provisioned do |prov|
    prov.vm.box = "provisioned"
    prov.vm.network :private_network, ip: "192.168.33.10"
    prov.vm.synced_folder "./", "/vagrant_data"
    prov.vm.provision :shell, :inline => $script
  end
end
