# display

if $(gls &>/dev/null); then
  alias l="clear && lsr"
  alias ls="gls -F --color=auto"
  alias ll="gls -l --color=auto"
  alias la='gls -A --color=auto'
  alias er="clear && tree -C"
fi

# navigation

alias j="cd .. && l"
alias k="cd - && l"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# make mv ask before overwriting a file by default
alias mv='mv -i'
