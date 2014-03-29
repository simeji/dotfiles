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
  makeSymLink "${dir}.${vimrc}" "/${vimrc}"
  makeSymLink "${dir}.${screenrc}" "/${screenrc}"
  makeSymLink "${dir}.${tmuxconf}" "/${tmuxconf}"
  makeSymLink "${dir}.${zshrc}" "/${zshrc}"
  makeSymLink "${dir}.${dircolors}" "/${dircolors}"
  makeSymLink "${dir}.${gitconfig}" "/${gitconfig}"
}

vimenv() {
  which git || yum install git -y
  test -d ~/.vim/bundle/vundle || git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  vim ~/.vimrc -c BundleInstall
}

case "$1" in
vimenv)
vimenv && exit 0
$1
;;
dotfiles)
dotfiles && exit 0
$1
;;
*)
echo $"Usage: $0 {dotfiles|vimenv}"
exit 2
esac
exit $?
