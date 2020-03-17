# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

#=======================================================
# Configuración general
#=======================================================
		config.vm.box = "ubuntu/bionic64"
    config.ssh.insert_key = false
    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
    end
    config.vm.box_check_update = false
	
#=======================================================
# Configuración master 1
#=======================================================
    config.vm.define "master1" do |node|
		node.vm.network "private_network", ip: "192.168.50.11"
		node.vm.hostname = "master1"
		

		config.vm.provision "file", source: "./ssh-key.pub", destination: "~/.ssh/ssh-key.pub"
		config.vm.provision "shell", inline: <<-SHELL
			cat /home/vagrant/.ssh/ssh-key.pub >> /home/vagrant/.ssh/authorized_keys
		SHELL

		config.vm.provider :virtualbox do |vb|
			vb.customize ["modifyvm", :id, "--memory", "2024"]
		end
	end
#=======================================================
# Configuración master 2
#=======================================================
    config.vm.define "master2" do |node|
		node.vm.network "private_network", ip: "192.168.50.12"
		node.vm.hostname = "master2"
		
		config.vm.provision "file", source: "./ssh-key.pub", destination: "~/.ssh/ssh-key.pub"
		config.vm.provision "shell", inline: <<-SHELL
			cat /home/vagrant/.ssh/ssh-key.pub >> /home/vagrant/.ssh/authorized_keys
		SHELL

		config.vm.provider :virtualbox do |vb|
			vb.customize ["modifyvm", :id, "--memory", "2024"]
		end
	end
#=======================================================
# Configuración master 3
#=======================================================
    config.vm.define "master3" do |node|
		node.vm.network "private_network", ip: "192.168.50.13"
		node.vm.hostname = "master3"

		config.vm.provision "file", source: "./ssh-key.pub", destination: "~/.ssh/ssh-key.pub"
		config.vm.provision "shell", inline: <<-SHELL
			cat /home/vagrant/.ssh/ssh-key.pub >> /home/vagrant/.ssh/authorized_keys
		SHELL

		config.vm.provider :virtualbox do |vb|
			vb.customize ["modifyvm", :id, "--memory", "2024"]
		end
	end
#=======================================================
# Configuración node 1
#=======================================================
	config.vm.define "node1" do |node|
		node.vm.network "private_network", ip: "192.168.50.21"
		node.vm.hostname = "node1"
		
		config.vm.provision "file", source: "./ssh-key.pub", destination: "~/.ssh/ssh-key.pub"
		config.vm.provision "shell", inline: <<-SHELL
			cat /home/vagrant/.ssh/ssh-key.pub >> /home/vagrant/.ssh/authorized_keys
		SHELL
	end
#=======================================================
# Configuración node 2
#=======================================================
	config.vm.define "node2" do |node|
		node.vm.network "private_network", ip: "192.168.50.22"
		node.vm.hostname = "node2"
		
		config.vm.provision "file", source: "./ssh-key.pub", destination: "~/.ssh/ssh-key.pub"
		config.vm.provision "shell", inline: <<-SHELL
			cat /home/vagrant/.ssh/ssh-key.pub >> /home/vagrant/.ssh/authorized_keys
		SHELL
	end
# #=======================================================
# # Configuración yum proxy
# #=======================================================
# 	config.vm.define "yum-proxy" do |node|
# 		node.vm.network "private_network", ip: "192.168.50.99"
# 		node.vm.hostname = "cache"
		
# 		config.vm.provider :virtualbox do |vb|
# 			vb.customize ["modifyvm", :id, "--memory", "512"]
# 		end

# 		config.vm.provision "file", source: "./ssh-key.pub", destination: "~/.ssh/ssh-key.pub"
# 		config.vm.provision "shell", inline: <<-SHELL
# 			cat /home/vagrant/.ssh/ssh-key.pub >> /home/vagrant/.ssh/authorized_keys
# 		SHELL
# 	end
end
