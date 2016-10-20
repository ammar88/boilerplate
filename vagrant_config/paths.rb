# -*- mode: ruby -*-
# vi: set ft=ruby :

# Ansible directory
ANSIBLE_PATH = './provisioning'
ANSIBLE_ROLES_PATH = File.join(ANSIBLE_PATH, 'vendor', 'roles')
# Config file path
ANSIBLE_CONFIG_FILE = File.join(ANSIBLE_PATH, 'group_vars', 'development', 'wordpress_sites.yml')
ANSIBLE_PLAYBOOK_DEV = File.join(ANSIBLE_PATH, 'dev.yml')

# Check if requirements have been installed.
if !Dir.exists?(ANSIBLE_ROLES_PATH)
  fail_with_message "You are missing the required Ansible Galaxy roles, please install them with this command:\nansible-galaxy install -r requirements.yml"
end

# Check config file exists
if File.exists?(ANSIBLE_CONFIG_FILE)
	wordpress_sites = YAML.load_file(ANSIBLE_CONFIG_FILE)['wordpress_sites']
	if wordpress_sites.to_h.empty?
		fail_with_message "No sites found in #{ANSIBLE_CONFIG_FILE}."
	end
else
  fail_with_message "#{ANSIBLE_CONFIG_FILE} was not found. Please set `ANSIBLE_PATH` in your Vagrantfile."
end