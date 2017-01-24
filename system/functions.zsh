# display

function lsr() {
  gls \
    --ignore={#*,*~,.#*,.DS_Store,.tern-port,.git,node_modules} \
    -go \
    -l \
    --almost-all \
    --human-readable \
    --group-directories-first \
    --color=always \
    --time-style='+%b-%d-%y %H:%M' \
    $@ \
      | tail -n+2 \
      | awk '{
            printf "\033[0;30m%-11s %-4s %9s %s\033[0m %s %s %s\n", $1, $3, $4, $5, $6, $7, $8
          }'
}

# navigation

function cd() {
  builtin cd "$@"
  clear
  lsr
  test -f .env && source .env
  test ! -z $TMUX && set-window-title "`basename $PWD`"
  set-tab-title "`basename $PWD`"
}

function set-tab-title() {
  local title_format{,ted}
  zstyle -s ':prezto:module:terminal:tab-title' format 'title_format' || title_format="%s"
  zformat -f title_formatted "$title_format" "s:$argv"

  printf "\e]1;%s\a" ${(V%)title_formatted}
}

function set-window-title() {
  local title_format{,ted}
  zstyle -s ':prezto:module:terminal:window-title' format 'title_format' || title_format="%s"
  zformat -f title_formatted "$title_format" "s:$argv"

  if [[ "$TERM" == screen* ]]; then
    title_format="\ek%s\e\\"
  else
    title_format="\e]2;%s\a"
  fi

  printf "$title_format" "${(V%)title_formatted}"
}

# search

function gre() {
  local ignored=$(get_ignored)
  local dirs=$(sed -n 1p <<< $ignored)
  local results=$(
    map_to_option '--exclude-dir' $dirs \
      | xargs -J % /usr/bin/grep % $@
  )

  if [ $results ]; then
    while read line; do
      local file=$(cut -d ':' -f1 <<< $line)
      git check-ignore -q $file
      test $? != 0 && echo $line
    done <<< $results
  fi
}

function tree() {
  set -A array
  array+=".git"

  # don't show files that we ignore globally in git
  array+=$(rows_to_list ~/.dotfiles/git/gitignore "|")

  if [ -f .gitignore ]; then
    # don't show files that we ignore locally in git
    array+=$(rows_to_list .gitignore "|")
  fi

  IFS="|"
  /usr/local/bin/tree -I "${array[*]}" -a --dirsfirst $@
  unset $array
}

function get_ignored() {
  local patterns=$(
    cat ~/.dotfiles/git/gitignore \
      | /usr/bin/grep -v '^#'
  )

  patterns+=$(
    find . -maxdepth 3 -name '.gitignore' -type f -exec \
      sed "s,\(.*\),{}\1," {} \; \
        | /usr/bin/grep -v '^#' \
        | sed 's,\.gitignore,,' \
        | sed 's,^\.\/\(.*\),\1,'
  )

  local ignores=''
  local dirs='.git '
  while read f; do
    if [ -d $f ]; then
      dirs+="$f "
    else
      ignores+="$f "
    fi
  done <<< $(tr -s '\n' <<< $patterns)

  echo "$dirs\n$ignores"
}

function map_to_option() {
  local option=$1
  local list=$(tr ' ' '\n' <<< $2)

  echo $list \
    | sed "s,\(.*\),$option=\1," \
    | tr '\n' ' '
}

function rows_to_list() {
  cat $1 \
    | tr "\n" "$2" \
    | tr -s "$2" \
    | sed "s/\(.*\)$2$/\1/"
}
