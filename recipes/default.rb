#
# Cookbook Name:: dokku
# Recipe:: default
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
