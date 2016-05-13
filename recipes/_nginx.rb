#
# Cookbook Name:: dokku
# Recipe:: _nginx
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

package "nginx"

service "nginx" do
  supports status: true, restart: true, reload: true
  action :start
end
