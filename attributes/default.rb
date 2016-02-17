#
# Cookbook Name:: dokku
# Attributes:: default
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

default["dokku"]["domain"] = nil
default["dokku"]["ssh_keys"] = []
default["dokku"]["plugins"] = []
default["dokku"]["apps"] = []

default["dokku"]["nginx"]["server_tokens"] = "off"
default["dokku"]["nginx"]["ssl_session_cache"] = "shared:SSL:20m"
default["dokku"]["nginx"]["ssl_session_timeout"] = "10m"
default["dokku"]["nginx"]["ssl_ciphers"] = "EECDH+AES128:RSA+AES128:" \
  "EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5"

default["dokku"]["enable_global_certificate"] = false
