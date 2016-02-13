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
* `dokku::plugins`: Manages plugins from attributes.
* `dokku::apps`: Manages apps from attributes.

### Attributes

#### default

* `node["dokku"]["domain"]`: The domain for Dokku to serve under.
* `node["dokku"]["ssh_keys"]`: A list of ssh keys to allow for deployment.
* `node["dokku"]["plugins"]`: A list of plugins to manage.
* `node["dokku"]["apps"]`: A list of apps to manage.

These optional settings can be overridden to customise the default Nginx
configuration (which is used for all apps):

* `node["dokku"]["nginx"]["server_tokens"]`: Defaults to `off`.
* `node["dokku"]["nginx"]["ssl_session_cache"]`: Defaults to `shared:SSL:20m`.
* `node["dokku"]["nginx"]["ssl_session_timeout"]`: Defaults to `10m`.
* `node["dokku"]["nginx"]["ssl_ciphers"]`: Defaults to
  `EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5`

### LWRPs

#### `ssh_key`

Provides `add` and `remove` actions for setting the Dokku SSH public keys.
Defaults to `add`. e.g.:

```ruby
dokku_ssh_key "user" do
  key "ssh_public_key"
  action :add
end
```

#### `plugin`

Provides `install` and `uninstall` actions for handling [plugins][]. Defaults
to `install`. e.g.:

```ruby
dokku_plugin "redis" do
  url "https://github.com/dokku/dokku-redis.git"
end
```

#### `app`

Provides `create`, `destroy` and `rename` actions for managing Dokku apps.
Defaults to `create`. e.g.:

```ruby
dokku_app "demo"
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
