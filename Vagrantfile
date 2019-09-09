# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "generic/ubuntu1804"
	config.vm.network :forwarded_port, guest: 81, host: 8100
	config.vm.network :private_network, ip: "192.168.10.170"
	config.vm.network :public_network
	config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

	config.vm.provider "virtualbox" do |vb|
		vb.memory = "2024"
	end
	
	config.vm.provision :shell, :path => "install.sh"
end
