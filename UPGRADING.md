# UPGRADING

## 1.3.0 => 2.0.0

This release upgrades `dokku` from `0.4.14` to `0.5.6`.

* A Chef run will fail when updating `dokku` and `herokuish`. You can fix this
  by upgrading them manually first:
```sh
    sudo apt-get install herokuish=0.3.12
    sudo apt-get install dokku=0.5.6
```
* Global certificates are no longer supported from dokku 0.5.0 onwards. You'll
  need to provide SSL certificates for each deployed app.
* You'll also want to run: `dokku ps:rebuildall` to rebuild all of the
  containers, too.
