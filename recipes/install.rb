#
# Cookbook Name:: dokku
# Recipe:: install
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

include_recipe "dokku::_nginx"
include_recipe "openssl"

package "apt-transport-https"

docker_service "default" do
  action %i[create start]
end

packagecloud_repo "dokku/dokku" do
  type "deb"
end

execute "install-dokku-plugin-core-dependencies" do
  command "dokku plugin:install-dependencies --core"
  action :nothing
end

%w(herokuish sshcommand plugn dokku).each do |pkg|
  execute "hold-dependency-#{pkg}" do
    command "apt-mark hold #{pkg}"
    action :nothing
  end

  execute "unhold-dependency-#{pkg}" do
    command "apt-mark unhold #{pkg}"
    action :nothing
  end

  package pkg do
    version node["dokku"]["package"][pkg]["version"]

    notifies :run, "execute[unhold-dependency-#{pkg}]", :immediately

    if pkg == "dokku"
      notifies :run,
               "execute[install-dokku-plugin-core-dependencies]",
               :immediately
    end

    notifies :run, "execute[hold-dependency-#{pkg}]", :immediately
  end
end

file "/home/dokku/VHOST" do
  content node["dokku"]["domain"] || node["fqdn"]
end

openssl_dhparam node["dokku"]["nginx"]["dhparam_file"] do
  key_length node["dokku"]["nginx"]["dhparam_key_length"]

  notifies :restart, "service[nginx]", :delayed
end

dokku_nginx_template "global"
