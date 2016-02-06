if defined?(ChefSpec)
  ChefSpec.define_matcher :dokku_ssh_keys
  ChefSpec.define_matcher :dokku_plugins
  ChefSpec.define_matcher :dokku_app

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

  def create_dokku_app(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:dokku_app,
                                            :create,
                                            resource_name)
  end

  def destroy_dokku_app(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:dokku_app,
                                            :destroy,
                                            resource_name)
  end

  def rename_dokku_app(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:dokku_app,
                                            :rename,
                                            resource_name)
  end
end
