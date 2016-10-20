# -*- mode: ruby -*-
# vi: set ft=ruby :

# Fail with msg function
def fail_with_message(msg)
  fail Vagrant::Errors::VagrantError.new, msg
end
#  
def local_site_path(site)
  File.expand_path(site['local_path'], ANSIBLE_PATH)
end
# 
def nfs_path(site_name)
  "/vagrant-nfs-#{site_name}"
end
# 
def remote_site_path(site_name, site)
  "/srv/www/#{site_name}/#{site['current_path'] || 'current'}"
end