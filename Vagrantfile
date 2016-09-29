# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.50.50"

  config.vm.synced_folder "./app", "/var/www"

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "./provisioning/playbook.yml"
    ansible.limit = "local"
    ansible.inventory_path = "./provisioning/hosts"
    ansible.ask_vault_pass = true
  end

end