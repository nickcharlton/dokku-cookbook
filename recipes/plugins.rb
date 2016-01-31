#
# Cookbook Name:: dokku
# Recipe:: plugins
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

include_recipe "nginx"

plugins = node["dokku"]["plugins"]

plugins.each do |plugin|
  dokku_plugins plugin["name"] do
    url plugin["url"]
    action plugin.fetch("action", "install").to_sym
  end
end

# installing plugins will cause the same problem as with the install recipe:
# it gets redefined when the core dependencies are installed
file "/etc/nginx/conf.d/server_names_hash_bucket_size.conf" do
  action :delete

  notifies :restart, "service[nginx]", :delayed
end
