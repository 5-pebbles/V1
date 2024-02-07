# .zshrc
EDITOR=nvim

if [[ "$TERM" == "foot" ]]; then
    PROMPT='🌸[%(!.%F{red}.%F{green)%~%f]%(!.#.$) '
else
    PROMPT='%1{🌸%}[%(!.%F{red}.%F{green)%~%f]%(!.#.$) '
fi

alias 'l'='ls -A'
alias 'c'='cd'
alias 'm'='mv'
alias 'r'='rm -r'
alias 'v'="$EDITOR"
alias 'q'='exit'
