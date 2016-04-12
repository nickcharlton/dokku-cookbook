#
# Cookbook Name:: dokku
# Recipe:: install
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

include_recipe "nginx"
include_recipe "openssl"

package "apt-transport-https"

docker_service "default" do
  action [:create, :start]
end

packagecloud_repo "dokku/dokku" do
  type "deb"
end

execute "install-dokku-plugin-core-dependencies" do
  command "dokku plugin:install-dependencies --core"
  action :nothing
end

%w(herokuish sshcommand plugn dokku).each do |pkg|
  package pkg do
    version node["dokku"]["package"][pkg]["version"]

    if pkg == "dokku"
      notifies :run,
               "execute[install-dokku-plugin-core-dependencies]",
               :immediately
    end
  end
end

# otherwise, it gets redefined when the core dependencies are installed
file "/etc/nginx/conf.d/server_names_hash_bucket_size.conf" do
  action :delete

  notifies :restart, "service[nginx]", :delayed
end

file "/home/dokku/VHOST" do
  content node["dokku"]["domain"] || node["fqdn"]
end

openssl_dhparam node["dokku"]["nginx"]["dhparam_file"] do
  key_length node["dokku"]["nginx"]["dhparam_key_length"]

  notifies :restart, "service[nginx]", :delayed
end

dokku_nginx_template "global"
