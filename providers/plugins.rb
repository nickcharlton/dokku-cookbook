#
# Cookbook Name:: dokku
# Provider:: plugins
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.
#

def whyrun_supported?
  true
end

action :install do
  execute "installing plugin: #{new_resource.name}" do
    command "dokku plugin:install #{new_resource.url} #{new_resource.name}"

    not_if do
      plugin_dir = "/var/lib/dokku/plugins/available/#{new_resource.name}"
      FileTest.directory?(plugin_dir)
    end
  end
end

action :uninstall do
  execute "uninstalling plugin: #{new_resource.user}" do
    command "dokku plugin:uninstall #{new_resource.name}"
  end
end
