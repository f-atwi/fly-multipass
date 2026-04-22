[![Shell](https://img.shields.io/badge/shell-bash%20|%20zsh%20|%20ksh%20-blue.svg)]()
[![Licence](https://img.shields.io/badge/licence-MIT-blue.svg)](https://shields.io/)

# fly-multipass
Multipass transport plugin for thefly

Built for [thefly](https://github.com/joknarf/thefly).

## features

The following features are available:

* open your Fly environment inside a Multipass instance without using ssh
* keep your Fly plugins, aliases, and shell environment available inside the instance
* start an interactive shell in the instance with `flymp <instance>`
* force destination shell using `flympb`, `flympz`, or `flympk`
* use a short alias with `fmp`

## Install

* You can install using [thefly](https://github.com/joknarf/thefly) when the repository is published:
```
fly add f-atwi/fly-multipass
```
* Or you can test using a local clone and wire it into your Fly plugins:
```
ln -sfn /path/to/fly-multipass ~/.fly.d/plugins/multipass
ln -sfn ../plugins/multipass ~/.fly.d/plugins.d/50-multipass
. ~/.fly.d/fly source
```

the implementation lives in `multipass`, while `multipass.plugin.bash`, `multipass.plugin.zsh`, and `multipass.plugin.ksh` can all point to it.

## Usage

Open an interactive Fly shell in a Multipass instance:
```
flymp primary
```

Force the destination shell:
```
flympb primary
flympz primary
flympk primary
```

## Notes

* this plugin expects Fly to already be loaded in the current shell
* current support targets bash, zsh, and ksh
* fish is intentionally left for a later step because Fly handles fish plugins differently