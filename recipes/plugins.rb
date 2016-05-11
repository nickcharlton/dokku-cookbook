#
# Cookbook Name:: dokku
# Recipe:: plugins
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

plugins = node["dokku"]["plugins"]

plugins.each do |plugin|
  dokku_plugin plugin["name"] do
    url plugin["url"]
    committish plugin["committish"] if plugin["committish"]
    action plugin.fetch("action", "install").to_sym
  end
end
