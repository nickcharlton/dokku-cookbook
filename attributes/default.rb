#
# Cookbook Name:: dokku
# Attributes:: default
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

default["dokku"]["package"]["dokku"]["version"] = "0.4.14"
default["dokku"]["package"]["herokuish"]["version"] = "0.3.8"
default["dokku"]["package"]["sshcommand"]["version"] = "0.1.0"
default["dokku"]["package"]["plugn"]["version"] = "0.2.1"

default["dokku"]["domain"] = nil
default["dokku"]["ssh_keys"] = []
default["dokku"]["plugins"] = []
default["dokku"]["apps"] = []

default["dokku"]["nginx"]["server_tokens"] = "off"
default["dokku"]["nginx"]["ssl_session_cache"] = "shared:SSL:20m"
default["dokku"]["nginx"]["ssl_session_timeout"] = "10m"
default["dokku"]["nginx"]["ssl_protocols"] = "TLSv1 TLSv1.1 TLSv1.2"
default["dokku"]["nginx"]["ssl_ciphers"] = "EECDH+AESGCM:EDH+AESGCM:" \
  "AES256+EECDH:AES256+EDH"
default["dokku"]["nginx"]["dhparam_file"] = "/etc/ssl/certs/dhparam.pem"
default["dokku"]["nginx"]["dhparam_key_length"] = 4096
