#
# Cookbook Name:: dokku
# Provider:: ssh_key
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.
#

def whyrun_supported?
  true
end

action :add do
  execute "adding ssh key for #{new_resource.user}" do
    command "echo #{new_resource.key} | sshcommand " \
            "acl-add dokku #{new_resource.user}"

    not_if do
      system("grep #{new_resource.user} /home/dokku/.ssh/authorized_keys")
    end
  end
end

action :remove do
  execute "removing ssh key for #{new_resource.user}" do
    command "echo #{new_resource.key} | sshcommand " \
            "acl-remove dokku #{new_resource.user}"
  end
end
