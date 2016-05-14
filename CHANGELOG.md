# CHANGELOG

## 1.3.0 (14/05/2016)

* Fixes a bug where deleting apps would fail because it'd return a `1`.
* Adds support for specifying the "committish" of a plugin. ([PR #13][])
* Brings the Nginx configuration inline instead of a dependency. ([PR #14][])

[PR #13]: https://github.com/nickcharlton/dokku-cookbook/pull/13
[PR #14]: https://github.com/nickcharlton/dokku-cookbook/pull/14

## 1.2.0 (18/04/2016)

* Install and mark a hold on specific versions of dokku dependencies to guard
  against breakages ([PR #11][])
* Fix test run issues with Docker ([PR #12][]).

[PR #11]: https://github.com/nickcharlton/dokku-cookbook/pull/11
[PR #12]: https://github.com/nickcharlton/dokku-cookbook/pull/12

## 1.1.0 (05/03/2016)

* Improves the provided SSL ciphers and adds an option for configuring SSL
  providers.
* Includes generation of `dhparams` to safeguard against Weak DH attacks.

## 1.0.0 (19/02/2016)

* Initial release.
