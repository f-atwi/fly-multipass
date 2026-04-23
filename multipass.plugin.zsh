[ "$_fly_multipass_loaded" ] && return 0
_fly_multipass_loaded=1

_fly_multipass_usage()
{
    cat - <<'EOF'
usage: flympsh <instance> [-- <command> [args...]]

Open a Fly environment inside a Multipass instance.
EOF
}

_fly_multipass_prepare()
{
    : "${FLY_HOME:=$HOME}"
    : "${FLY_TMPDIR:=/tmp}"
    : "${FLY_TARZ:=-z}"
    : "${_fly_lib:=$FLY_HOME/.fly.d/.fly.lib}"
    : "${_fly_uuid:=$(cat "$FLY_HOME/.fly.d/.flyuuid" 2>/dev/null || uuidgen)}"

    command -v multipass >/dev/null 2>&1 || {
        echo "swarmpass: multipass command not found" >&2
        return 1
    }
    type _fly_pkg_warp >/dev/null 2>&1 || {
        echo "swarmpass: load Fly first (. ~/.fly.d/fly source)" >&2
        return 1
    }

    _fly_tmpdir="$FLY_TMPDIR/.fly.$(id -u)/$_fly_uuid"
    _fly_tarz="$FLY_TARZ"
}

_fly_multipass_stage()
{
    typeset instance stage_cmd

    instance="$1"
    stage_cmd="$(_fly_xpretar);$(_fly_xpackage)"
    _fly_package | multipass exec "$instance" -- /bin/sh -c "$stage_cmd"
}

_fly_multipass_attach()
{
    typeset instance attach_cmd

    instance="$1"
    attach_cmd="FLY_HOME=$_fly_tmpdir; . \"$_fly_tmpdir/.fly.d/.fly.lib/.loginshell\""
    multipass exec "$instance" -- /bin/sh -c "$attach_cmd"
}

_fly_multipass_run()
{
    typeset instance

    instance="$1"
    shift
    [ "$instance" ] || {
        _fly_multipass_usage >&2
        return 1
    }

    _fly_multipass_prepare || return $?

    _fly_multipass_stage "$instance" || return $?
    _fly_multipass_attach "$instance"
}

flympsh()
{
    _fly_multipass_run "$@"
}

fmpsh()
{
    flympsh "$@"
}

flympshb()
{
    _fly_destshell=bash flympsh "$@"
}

flympshz()
{
    _fly_destshell=zsh flympsh "$@"
}

flympshk()
{
    _fly_destshell=ksh flympsh "$@"
}
