# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
echo 'export LC_ALL=en_US.UTF-8' > /etc/bash.bashrc
echo 'export LANG=en_US.UTF-8' > /etc/bash.bashrc
echo 'export LANGUAGE=en_US.UTF-8' > /etc/bash.bashrc
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.define :precise32 do |precise_config|
    precise_config.vm.box = "precise32"
    precise_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
    precise_config.vm.network :private_network, ip: "192.168.33.10"
    precise_config.vm.synced_folder "./", "/vagrant_data"
    precise_config.vm.provision :shell, :inline => $script
  end

  config.vm.define :provisioned do |prov|
    prov.vm.box = "provisioned"
    prov.vm.box_url = "http://deploying-rails.s3.amazonaws.com/precise32-provisioned.box"
    prov.vm.network :private_network, ip: "192.168.33.10"
  end
end
