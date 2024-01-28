# .zshrc
EDITOR=nvim

PROMPT='%1{🌸%}[%(!.%F{red}.%F{green)%~%f]%(!.#.$) '

lf () {
    # `command` is needed in case this is aliased to `lf`
    cd "$(command lf -print-last-dir "$@")"
}

alias 'l'='ls -A'
alias 'c'='cd'
alias 'm'='mv'
alias 'r'='rm -r'
alias 'v'="$EDITOR"
alias 'q'='exit'
