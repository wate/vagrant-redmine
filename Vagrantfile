# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

# All Vagrant configuration is done below. The '2' in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure('2') do |config|
  config.vm.box = 'bento/debian-13'
  # config.vm.box_check_update = false

  config.vm.network 'private_network', ip: '192.168.33.101'
  config.vm.network 'forwarded_port', guest: 80, host: 8080
  config.vm.network 'forwarded_port', guest: 8025, host: 8025

  config.vm.hostname = 'redmine'
  config.vm.provider 'virtualbox' do |vb|
    vb.name = 'redmine'
    vb.memory = 2048
  end

  vm_domain = ENV["VAGRANT_VM_DOMAIN"] || "redmine.local"
  vm_host_aliases = [
    "mailpit." + vm_domain
  ]
  ## plugin vagrant-hostsupdater
  if Vagrant.has_plugin?("vagrant-hostsupdater")
    config.vm.hostname = vm_domain
    config.hostsupdater.aliases = vm_host_aliases
  end
  ## plugin vagrant-hostmanager
  if Vagrant.has_plugin?("vagrant-hostmanager")
    config.hostmanager.enabled = false
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.aliases = vm_host_aliases
  end

  LDE_CONFIG_DIR = 'provision'
  ANSIBLE_CONFIG_FILE = File.expand_path(File.join(LDE_CONFIG_DIR, 'ansible.cfg'))
  ANSIBLE_GALAXY_ROLE_FILE = File.expand_path(File.join(LDE_CONFIG_DIR, 'requirements.yml'))
  ANSIBLE_PLAYBOOK = File.expand_path(File.join(LDE_CONFIG_DIR, 'playbook.yml'))
  ANSIBLE_VERITY_PLAYBOOK = File.expand_path(File.join(LDE_CONFIG_DIR, 'verify.yml'))
  ANSIBLE_GALAXY_ROLES_PATH = File.join('.vagrant', 'provisioners', 'ansible', 'roles')
  ansible_extra_vars = {}
  ansible_provision_tags = []
  ansible_provision_skip_tags = []
  ansible_raw_arguments = []
  provision_role_update = !File.exist?(ANSIBLE_GALAXY_ROLES_PATH)
  provision_config = nil
  provision_config_file_dirs = ['.', LDE_CONFIG_DIR]
  provision_config_file_dirs.each do |target_dir|
    provision_config_file = File.expand_path(File.join(target_dir.to_s, 'provision_config.yml'))
    if File.exist?(File.expand_path(provision_config_file))
      provision_config = YAML.load_file(provision_config_file)
      break
    end
  end
  if provision_config
    if provision_config.key?("role_update") && !provision_config["role_update"].nil?
      provision_role_update = provision_config["role_update"]
    end
    if provision_config.key?("extra_var") && !provision_config["extra_var"].nil?
      ansible_extra_vars.merge!(provision_config["extra_var"])
    end
    if provision_config.key?("pre_task") && !provision_config["pre_task"].nil?
      pre_task_setting = provision_config["pre_task"]
      if pre_task_setting.key?("update_cache") && !pre_task_setting["update_cache"].nil?
        ansible_extra_vars["pre_task_update_cache"] = pre_task_setting["update_cache"]
      end
      if pre_task_setting.key?("update_package") && !pre_task_setting["update_package"].nil?
        ansible_extra_vars["pre_task_update_package"] = pre_task_setting["update_package"]
      end
    end
    if provision_config.key?("tags") && !provision_config["tags"].nil?
      ansible_provision_tags = provision_config["tags"]
    end
    if provision_config.key?("skip_tags") && !provision_config["skip_tags"].nil?
      ansible_provision_skip_tags = provision_config["skip_tags"]
    end
    if provision_config.key?("raw_arguments") && !provision_config["raw_arguments"].nil?
      ansible_raw_arguments.concat(provision_config["raw_arguments"]).uniq!
    end
  end
  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = ANSIBLE_PLAYBOOK
    ansible.config_file = ANSIBLE_CONFIG_FILE if File.exist?(ANSIBLE_CONFIG_FILE)
    ansible.galaxy_role_file = ANSIBLE_GALAXY_ROLE_FILE if File.exist?(ANSIBLE_GALAXY_ROLE_FILE) && provision_role_update
    ansible.galaxy_roles_path = ANSIBLE_GALAXY_ROLES_PATH
    ansible.compatibility_mode = '2.0'
    ansible.extra_vars = ansible_extra_vars if ansible_extra_vars.length > 0
    ansible.tags = ansible_provision_tags if ansible_provision_tags.length > 0
    ansible.skip_tags = ansible_provision_skip_tags if ansible_provision_skip_tags.length > 0
    ansible.raw_arguments = ansible_raw_arguments if ansible_raw_arguments.length > 0
  end

  if File.exist?(ANSIBLE_VERITY_PLAYBOOK)
    config.vm.provision 'ansible' do |ansible|
      ansible.playbook = ANSIBLE_VERITY_PLAYBOOK
      ansible.config_file = ANSIBLE_CONFIG_FILE if File.exist?(ANSIBLE_CONFIG_FILE)
      ansible.galaxy_roles_path = ANSIBLE_GALAXY_ROLES_PATH
      ansible.compatibility_mode = '2.0'
      ansible.extra_vars = ansible_extra_vars if ansible_extra_vars.length > 0
      ansible.tags = ansible_provision_tags if ansible_provision_tags.length > 0
      ansible.skip_tags = ansible_provision_skip_tags if ansible_provision_skip_tags.length > 0
      ansible.raw_arguments = ansible_raw_arguments if ansible_raw_arguments.length > 0
    end
  end
end
