bundle=~/.vim/bundle

if [ ! -d $bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim $bundle/Vundle.vim
fi

colors=~/.vim/colors/solarized.vim
rm $colors &>/dev/null
ln -s $bundle/vim-colors-solarized/colors/solarized.vim $colors

vim +PluginInstall +qall
