. "${BASH_SOURCE%/*}/swarmpass"

_swarmpass_instances()
{
    multipass list --format csv 2>/dev/null | awk -F, 'NR > 1 && $1 != "" { print $1 }'
}

_swarmpass_completion()
{
    local cur instances

    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"

    [[ $COMP_CWORD -gt 1 ]] && return

    instances="$(_swarmpass_instances | tr '\n' ' ')"
    COMPREPLY=($(compgen -W "$instances" -- "$cur"))
}

complete -F _swarmpass_completion fmpsh flympsh flympshb flympshz flympshk
