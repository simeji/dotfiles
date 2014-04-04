#!/bin/bash 

# Don't move this file

vimdir="vim"
vimrc="vimrc"
screenrc="screenrc"
tmuxconf="tmux.conf"
zshrc="zshrc"
gitconfig="gitconfig"
dircolors="dir_colors"

dir="${HOME}/"

targets=($vimdir $vimrc $tmuxconf $zshrc $gitconfig $dircolors)

# The function to make symbolic link
# Arguments
# $1 : target of symlink path
# $2 : linked file path
makeSymLink() {
  if [ -e "$1" ]; then
    echo "$1 is already exists"
  else
    case "$0" in
      /*) cur=`dirname "$0"` ;;
      *) cur=`dirname "$PWD/$0"` ;;
    esac
    ln -s $cur$2 $1
    if [ $? -eq 0 ]; then
      echo "create symlink $1"
    fi
  fi
}

dotfiles() {
  for target in ${targets[@]}; do
    if [ $# = 0 ]; then
      makeSymLink "${dir}.${target}" "/${target}"
    elif [ $1 = 'cleanup' -a -h "${dir}.${target}" ]; then
      rm -i $dir.$target
    fi
  done
}

vimenv() {
  which git || yum install git -y
  test -d ~/.vim/bundle/vundle || git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  vim ~/.vimrc -c NeoBundleInstall
}

case "$1" in
vimenv)
vimenv && exit 0
$1
;;
dotfiles)
dotfiles $2 && exit 0
$1
;;
*)
echo $"Usage: $0 { dotfiles | dofiles cleanup | vimenv }"
exit 2
esac
exit $?
