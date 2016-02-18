#
# Cookbook Name:: dokku
# Resource:: nginx_template
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.
#

actions :build
default_action :build

attribute :name, kind_of: String, name_attribute: true
