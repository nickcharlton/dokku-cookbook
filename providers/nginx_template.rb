#
# Cookbook Name:: dokku
# Provider:: nginx_template
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.
#

def whyrun_supported?
  true
end

action :build do
  template "/etc/nginx/conf.d/dokku.conf" do
    source "nginx.conf.erb"

    notifies :restart, "service[nginx]", :delayed
  end
end
