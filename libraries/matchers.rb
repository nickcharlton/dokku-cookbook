if defined?(ChefSpec)
  ChefSpec.define_matcher :dokku_ssh_keys
  ChefSpec.define_matcher :dokku_plugins

  def add_dokku_ssh_key(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:dokku_ssh_keys,
                                            :add,
                                            resource_name)
  end

  def remove_dokku_ssh_key(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:dokku_ssh_keys,
                                            :remove,
                                            resource_name)
  end

  def install_dokku_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:dokku_plugins,
                                            :install,
                                            resource_name)
  end

  def uninstall_dokku_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:dokku_plugins,
                                            :uninstall,
                                            resource_name)
  end

end
