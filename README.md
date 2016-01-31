# dokku

[![Build Status](https://travis-ci.org/nickcharlton/dokku-cookbook.svg?branch=master)](https://travis-ci.org/nickcharlton/dokku-cookbook)

This is a rebuild of the existing [chef-dokku][] cookbook, switching to a
direct package install and providing Lightweight Resource Providers (LWRPs) for
managing apps and it's components.

## Usage

### Recipes

* `dokku::default`: Includes install and provides the LWRPs.
* `dokku::install`: Installs and configured dokku from the Debian package.
* `dokku::ssh_keys`: Adds SSH keys from attributes.

### LWRPs

#### `ssh_keys`

Provides `add` and `remove` actions for setting the Dokku SSH public keys.
Defaults to `add`. e.g.:

```ruby
dokku_ssh_keys "user" do
  key "ssh_public_key"
  action :add
end
```

#### `plugins`

Provides `install` and `uninstall` actions for handling [plugins][]. Defaults
to `install`. e.g.:

```ruby
dokku_plugins "redis" do
  url "https://github.com/dokku/dokku-redis.git"
end
```

## Testing

[ChefSpec][] is used for unit tests. [Test Kitchen][] is used for integration
tests, with [serverspec][].

```sh
# unit tests
chef exec rspec
# integration tests
chef exec kitchen test
```

## Author

Copyright (c) Nick Charlton 2015. MIT licensed.

[chef-dokku]: https://github.com/fgrehm/chef-dokku
[plugins]: http://dokku.viewdocs.io/dokku/plugins/
[ChefSpec]: https://docs.chef.io/chefspec.html
[Test Kitchen]: http://kitchen.ci
[serverspec]: http://serverspec.org
