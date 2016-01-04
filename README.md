# dokku

This is a rebuild of the existing [chef-dokku][] cookbook, switching to a
direct package install and providing Lightweight Resource Providers (LWRPs) for
managing apps and it's components.

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
[ChefSpec]: https://docs.chef.io/chefspec.html
[Test Kitchen]: http://kitchen.ci
[serverspec]: http://serverspec.org
