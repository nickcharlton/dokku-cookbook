#
# Cookbook Name:: dokku
# Recipe:: certificates
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

certificates = data_bag("dokku_certificates")

certificates.each do |certificate_key|
  certificate = data_bag_item("dokku_certificates", certificate_key)

  dokku_certificate certificate["id"] do
    cert certificate["cert"]
    key certificate["key"]

    global certificate.fetch("global", false)
    action certificate.fetch("action", "add")
  end
end
