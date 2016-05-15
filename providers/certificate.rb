#
# Cookbook Name:: dokku
# Provider:: certificate
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.
#

def whyrun_supported?
  true
end

action :add do
  certificate_directory = "/home/dokku/#{new_resource.app}/tls"

  directory certificate_directory do
    owner "dokku"
    group "dokku"
    mode "0750"
  end

  file "#{certificate_directory}/server.key" do
    content new_resource.key
    owner "dokku"
    group "dokku"
    mode "0640"
  end

  file "#{certificate_directory}/server.crt" do
    content new_resource.cert
    owner "dokku"
    group "dokku"
    mode "0640"
  end

  execute "rebuilding nginx config for #{new_resource.app}" do
    command "dokku nginx:build-config #{new_resource.app}"

    notifies :restart, "service[nginx]", :delayed
  end
end

action :remove do
  execute "removing certificate for #{new_resource.app}" do
    command "dokku certs:remove #{new_resource.app}"

    not_if do
      !FileTest.exist?("/home/dokku/#{new_resource.app}/tls/server.crt")
    end
  end
end
