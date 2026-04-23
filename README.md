[![Shell](https://img.shields.io/badge/shell-bash%20|%20zsh%20|%20ksh%20-blue.svg)]()
[![Licence](https://img.shields.io/badge/licence-MIT-blue.svg)](https://shields.io/)

# swarmpass

Multipass transport plugin for thefly

Built for [thefly](https://github.com/joknarf/thefly).

## features

The following features are available:

* open your Fly environment inside a Multipass instance without using ssh
* keep your Fly plugins, aliases, and shell environment available inside the instance
* start an interactive shell in the instance with `flympsh <instance>`
* force destination shell using `flympshb`, `flympshz`, or `flympshk`
* use a short alias with `fmpsh`

## Install

* You can install using [thefly](https://github.com/joknarf/thefly):

```shell
fly add f-atwi/swarmpass
```

## Usage

Open an interactive Fly shell in a Multipass instance:

```shell
flympsh primary
```

Force the destination shell:

```shell
flympshb primary
flympshz primary
flympshk primary
```

Short alias:

```shell
fmpsh primary
```

## Notes

* this plugin expects Fly to already be loaded in the current shell
* this plugin expects multipass to already be installed
* current support targets bash, zsh, and ksh (if existing of target VM)
* fish is intentionally left for a later step because Fly handles fish plugins differently
