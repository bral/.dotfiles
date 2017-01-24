# spot for gems
export GEM_HOME=$HOME/.gem
export GEM_PATH=$HOME/.gem

# default cd path for interactive shells
if test “${PS1+set}”; then
  CDPATH=:"..:~:~/Projects";
fi
