# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
require './vagrant_config/helpers'
require './vagrant_config/paths'

# Box properties
ip = '192.168.50.5' # pick any local IP
cpus = 1
memory = 1024 # in MB
box = "bento/ubuntu-16.04"

# Vagrant version requirement
Vagrant.require_version '>= 1.8.5'

# Vagrant configuration
Vagrant.configure("2") do |config|

  # bento/ubuntu-16.04
  config.vm.box = box
  config.vm.network "private_network", ip: ip

  # 'site_hosts' object
  site_hosts = wordpress_sites.flat_map { |(_name, site)| site['site_hosts'] }

  # Sync folder
  # config.vm.synced_folder "./app", "/var/www/html", owner: "ubuntu", group: "www-data", mount_options: ["dmode=775,fmode=664"]

  # Canonical hostname
  main_hostname, *hostnames = site_hosts.map { |host| host['canonical'] }
  config.vm.hostname = main_hostname

  # List of redirects
  redirects = site_hosts.flat_map { |host| host['redirects'] }.compact

  # Vagrant Hostmanager
  if Vagrant.has_plugin? 'vagrant-hostmanager'
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.aliases = hostnames + redirects
  else
    fail_with_message "vagrant-hostmanager missing, please install the plugin with this command:\nvagrant plugin install vagrant-hostmanager"
  end

  # Vagrant BindFS
  if Vagrant.has_plugin? 'vagrant-bindfs'
    wordpress_sites.each_pair do |name, site|
      config.vm.synced_folder local_site_path(site), nfs_path(name), type: 'nfs'
      config.bindfs.bind_folder nfs_path(name), remote_site_path(name, site), u: 'vagrant', g: 'www-data', o: 'nonempty'
    end
  else
    fail_with_message "vagrant-bindfs missing, please install the plugin with this command:\nvagrant plugin install vagrant-bindfs"
  end
  
  # Ansible provisioning
  config.vm.provision :ansible do |ansible|
    ansible.playbook = ANSIBLE_PLAYBOOK_DEV
    ansible.ask_vault_pass = true
  end

  # Virtualbox settings
  config.vm.provider "virtualbox" do |v|
    v.name = config.vm.hostname
    v.memory = memory
    v.cpus = cpus
  end

end