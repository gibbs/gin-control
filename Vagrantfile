require 'yaml'

# YAML configuration
$yaml_path = File.dirname(__FILE__) + File::SEPARATOR
$yaml_file = $yaml_path + 'vagrant.yaml'

if !File.exists?($yaml_file)
  raise RuntimeError, sprintf("Failed to read %s", $yaml_file)
end

# Load the YAML configuration
$yaml = YAML.load_file $yaml_file

# Track plugin installation
plugin_installed = false

# Install plugins
$yaml['plugins'].each do |plugin|
  unless Vagrant.has_plugin?(plugin)
    system "vagrant plugin install #{plugin}"
    plugin_installed = true
  end
end

# Restart vagrant when a plugin is installed
if plugin_installed === true
  exec "vagrant #{ARGV.join' '}"
end

Vagrant.configure("2") do |config|

  # Host manager plugin
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true

  $yaml['machine'].each do |server,yaml|
    config.vm.define server do |machine|

      # Specify SSH username
      if ARGV[0] == "ssh"
        machine.ssh.username = yaml['username']
      end

      # Manage hostname aliases
      if yaml.include? 'aliases'
        machine.hostmanager.aliases = yaml['aliases'].join(" ")
      end

      # VM hostname
      machine.vm.hostname = yaml['hostname']
      machine.vm.network "private_network", ip: yaml['ip']

      # Vagrant box
      machine.vm.box = yaml['os']['box']
      machine.vm.box_check_update = false

      # Vagrant box URL
      if yaml['os'].include? 'url'
        machine.vm.box_url = yaml['os']['url']
      end

      # Vagrant box version
      if yaml['os'].include? 'version'
        machine.vm.box_version = yaml['os']['version']
      end

      # VirtualBox settings
      machine.vm.provider "virtualbox" do |v|
        v.name = yaml['hostname']
        v.memory = yaml['memory']
        v.cpus = yaml['cpus']
      end
    end
  end
end
