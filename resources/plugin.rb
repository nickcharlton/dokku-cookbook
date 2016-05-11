#
# Cookbook Name:: dokku
# Resource:: plugin
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.
#

actions :install, :uninstall
default_action :install

attribute :name, kind_of: String, name_attribute: true
attribute :url, kind_of: String
attribute :committish, kind_of: String
