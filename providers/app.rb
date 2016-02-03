#
# Cookbook Name:: dokku
# Provider:: app
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.
#

def whyrun_supported?
  true
end

action :create do
  execute "creating app: #{new_resource.name}" do
    command "dokku apps:create #{new_resource.name}"

    not_if { FileTest.directory?("/home/dokku/#{new_resource.name}") }
  end
end

action :rename do
  execute "renaming #{new_resource.name} to #{new_resource.new_name}" do
    command "dokku apps:rename #{new_resource.name} #{new_resource.new_name}"

    not_if do
      !FileTest.directory?("/home/dokku/#{new_resource.name}") ||
        FileTest.directory?("home/dokku/#{new_resource.new_name}")
    end
  end
end
