# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

# All Vagrant configuration is done below. The '2' in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure('2') do |config|
  config.vm.box = 'wate/debian-12'
  # config.vm.box_check_update = false

  config.vm.network 'private_network', ip: '192.168.33.101'
  config.vm.network 'forwarded_port', guest: 80, host: 3000
  config.vm.network 'forwarded_port', guest: 8025, host: 8025

  config.vm.hostname = 'redmine'
  config.vm.provider 'virtualbox' do |vb|
    vb.name = 'redmine'
    vb.memory = 2048
  end

  LDE_CONFIG_DIR = 'provision'
  ANSIBLR_CONFIG_FILE = File.expand_path(File.join(LDE_CONFIG_DIR, 'ansible.cfg'))
  ANSIBLR_GALAXY_ROLE_FILE = File.expand_path(File.join(LDE_CONFIG_DIR, 'requirements.yml'))
  ANSIBLR_PLAYBOOK = File.expand_path(File.join(LDE_CONFIG_DIR, 'playbook.yml'))
  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = ANSIBLR_PLAYBOOK
    ansible.config_file = ANSIBLR_CONFIG_FILE if File.exists?(ANSIBLR_CONFIG_FILE)
    ansible.galaxy_role_file = ANSIBLR_GALAXY_ROLE_FILE if File.exists?(ANSIBLR_GALAXY_ROLE_FILE)
    ansible.galaxy_roles_path = '.vagrant/provisioners/ansible/roles'
    ansible.compatibility_mode = '2.0'

    provision_tags = nil
    provision_tag_file_dirs = ['.', LDE_CONFIG_DIR]
    provision_tag_file_dirs.each do |target_dir|
      provision_tag_file = File.expand_path(File.join(target_dir.to_s, 'provision_tags.yml'))
      if File.exists?(File.expand_path(provision_tag_file))
        provision_tags = YAML.load_file(provision_tag_file)
        break
      end
    end
    if provision_tags
      if provision_tags.key?('tags') && !provision_tags['tags'].nil?
        ansible.tags = provision_tags['tags']
      end
      if provision_tags.key?('skip_tags') && !provision_tags['skip_tags'].nil?
        ansible.skip_tags = provision_tags['skip_tags']
      end
    end
  end
end
