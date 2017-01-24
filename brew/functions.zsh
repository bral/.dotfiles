function brew-upgrade-all() {
  brew doctor
  brew prune 2>/dev/null
  brew update
  brew list \
    | tr -s ' ' \
    | tr ' ' \n \
    | xargs brew upgrade 2>/dev/null
}
