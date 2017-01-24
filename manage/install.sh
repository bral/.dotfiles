if test ! (( $+commands[manage] )); then
  mkdir /tmp/manage
  cd /tmp/manage
  curl -L# https://github.com/mndvns/manage/archive/master.tar.gz \
    | tar zx --strip 1
  make install
fi
