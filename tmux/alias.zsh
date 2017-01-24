# -*- mode: shell-script; -*-

alias tma='tmux attach -t'
alias tmk='tmux kill-session -t'

tmka() {
  tmux kill-server 2>/dev/null
  test $? -gt 0 && >&2 echo "no tmux sessions"
}

tml() {
  tmux list-sessions 2>/dev/null
  test $? -gt 0 && >&2 echo "no tmux sessions"
}

tmn() {
  local dir=

  if [[ $# == 0 || $1 == '.' ]]; then
    dir=`realpath .`
  elif [ $1 =~ ^/ ]; then
    dir=$1
  else
    dir=$(
    find_project \
      $ZSH 1 $1 \
      $PROJECTS/$USER 1 $1 \
      $PROJECTS 2 $1 \
      ~ 1 $1 \
      ~ 2 $1 \
      /tmp 1 $1
    )
  fi

  if [ -z $dir ]; then
    tmux_start_session /tmp/$1
  else
    tmux_start_session $dir
  fi
}

tmux_start_session() {
  local dir=`echo $1 | sed "s,$HOME,~,"`
  vared -p "path: " dir
  test $? -gt 0 && return 1
  local realdir=`echo $dir | sed "s,~,$HOME,"`
  local safename=`echo $realdir | tr -d '.' | xargs basename`
  vared -p "name: " safename
  test $? -gt 0 && return 1

  if [[ ! -d $realdir ]]; then
    if [[ ! $realdir =~ ^/tmp/ ]]; then
      local answer=
      vared -p "make directory $realdir? [Yn] " answer
      if [[ ! -z $answer && ($answer = n || $answer = N) ]]; then
        >&2 echo "aborted."
        return 1
      fi
    fi

    echo "creating $dir..."
    mkdir -p $realdir
  fi

  tmux list-window -t $safename &>/dev/null

  if [ $? == 0 ]; then
    local answer=
    vared -p "session $safename already exists. attach? [Yn] " answer
    if [[ ! -z $answer && ($answer = n || $answer = N) ]]; then
      >&2 echo "aborted."
      return 1
    else
      tmux attach-session -t $safename
    fi
  else
    cd $realdir
    tmux new-session -s $safename
  fi
}

find_project() {
  local directory=$1
  local depth=$2
  local query=$3

  find \
    -L $directory \
    -maxdepth $depth \
    -type d -name $query \
    2> /dev/null | read -r project

  if [ ! -z $project ]; then
    echo $project
    return
  fi

  if [ $# -gt 3 ]; then
    shift 3
    find_project $@
  else
    >&2 echo "no projects found"
    return 1
  fi
}
