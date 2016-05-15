# dokku

[![Build Status](https://travis-ci.org/nickcharlton/dokku-cookbook.svg?branch=master)](https://travis-ci.org/nickcharlton/dokku-cookbook)

This is a Chef cookbook which provides the ability to install and configure
[dokku][]. It provides a set of recipes and Lightweight Resource Providers
(LWRPs) for managing apps and it's components.

It's [pinned][] against a [specific version of dokku][dokku_releases] to protect
your installation against being accidentally broken. This marks a `hold`
against the installed packages.

## Usage

### Recipes

* `dokku::default`: Includes install and provides the LWRPs.
* `dokku::install`: Installs and configures dokku from the Debian package.
* `dokku::ssh_keys`: Adds SSH keys from attributes.
* `dokku::plugins`: Manages plugins from attributes.
* `dokku::apps`: Manages apps from attributes.
* `dokku::certificates`: Manages certificates from a data bag.

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
* `node["dokku"]["nginx"]["ssl_protocols"]`: Defaults to
  `TLSv1 TLSv1.1 TLSv1.2`.
* `node["dokku"]["nginx"]["ssl_ciphers"]`: Defaults to
  `EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH`.
* `node["dokku"]["nginx"]["dhparam_file"]`: Defaults to
  `/etc/ssl/certs/dhparam.pem`.
* `node["dokku"]["nginx"]["dhparam_key_length"]`: Defaults to `4096`.


### Data Bags

#### `dokku_certificates`

Used in combination with the `dokku::certificates` recipe, these allow for
the management of SSL certificates apps. It's expected that they look like
this:

```json
{
  "id": "app-name",
  "cert": "",
  "key":
}
```

The `id` value should be the name of the app the certificate will set on. (The
format is inspired by the [certificate cookbook][].)

### LWRPs

#### `ssh_key`

Provides `add` and `remove` actions for setting the Dokku SSH public keys.
Defaults to `add`. e.g.:

```ruby
dokku_ssh_key "user" do
  key "ssh_public_key"
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

#### `certificate`

Provides `add` and `remove` actions for managing Dokku certificates. Defaults
to `add`: e.g.:

```ruby
dokku_certificate "wildcard" do
  cert "An SSL Certificate as a string"
  key "An SSL Certificate's private key as a string"
end
```

The name of the action should be the `id` of an available data bag item.

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

[dokku]: https://github.com/dokku/dokku
[pinned]: https://github.com/nickcharlton/dokku-cookbook/blob/master/attributes/default.rb#L7
[dokku_releases]: https://github.com/dokku/dokku/releases
[certificate cookbook]: https://github.com/atomic-penguin/cookbook-certificate
[plugins]: http://dokku.viewdocs.io/dokku/plugins/
[ChefSpec]: https://docs.chef.io/chefspec.html
[Test Kitchen]: http://kitchen.ci
[serverspec]: http://serverspec.org
