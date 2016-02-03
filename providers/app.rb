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
