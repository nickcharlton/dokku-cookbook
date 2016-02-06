#
# Cookbook Name:: dokku
# Resource:: app
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.
#

actions :create, :destroy, :rename
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :new_name, kind_of: String
