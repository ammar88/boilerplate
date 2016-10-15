# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version '>= 1.8.5'

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-16.04"

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.50.50"

  config.vm.synced_folder "./app", "/var/www/html", owner: "ubuntu", group: "www-data", mount_options: ["dmode=775,fmode=664"]

  if Vagrant.has_plugin? 'vagrant-hostmanager'
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.aliases = hostnames + redirects
  else
    fail_with_message "vagrant-hostmanager missing, please install the plugin with this command:\nvagrant plugin install vagrant-hostmanager"
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "./provisioning/playbook.yml"
    # ansible.limit = "local"
    # ansible.inventory_path = "./provisioning/hosts"
    ansible.ask_vault_pass = true
  end

end