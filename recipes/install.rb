#
# Cookbook Name:: dokku
# Recipe:: install
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

include_recipe "nginx"

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

package "dokku" do
  notifies :run, "execute[install-dokku-plugin-core-dependencies]", :immediately
end

# otherwise, it gets redefined when the core dependencies are installed
file "/etc/nginx/conf.d/server_names_hash_bucket_size.conf" do
  action :delete

  notifies :restart, "service[nginx]", :delayed
end

file "/home/dokku/VHOST" do
  content node["dokku"]["domain"] || node["fqdn"]
end
