#
# Cookbook Name:: dokku
# Recipe:: apps
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

apps = node["dokku"]["apps"]

apps.each do |app|
  dokku_app app["name"] do
    new_name app["new_name"] if app["new_name"]

    action app.fetch("action", "create").to_sym
  end
end
