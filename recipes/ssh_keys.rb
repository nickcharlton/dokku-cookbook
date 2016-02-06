#
# Cookbook Name:: dokku
# Recipe:: ssh_keys
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

available_keys = node["dokku"]["ssh_keys"]

available_keys.each do |ssh_key|
  dokku_ssh_key ssh_key["user"] do
    key ssh_key["key"]
    action ssh_key.fetch("action", "add").to_sym
  end
end
