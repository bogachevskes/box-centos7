# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "centos/7"
	config.vm.network :forwarded_port, guest: 82, host: 8200
	config.vm.network :private_network, ip: "192.168.10.171"
	config.vm.network :public_network
	config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

	config.vm.provider "virtualbox" do |vb|
		vb.memory = "2024"
	end
	
	config.vm.provision :shell, :path => "install.sh"
end