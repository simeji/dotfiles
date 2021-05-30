#!/bin/bash 

# Don't move this file

repodir=""
repo="https://github.com/simeji/dotfiles.git"
vimdir="vim"
vimrc="vimrc"
gvimrc="gvimrc"
screenrc="screenrc"
tmuxconf="tmux.conf"
zshrc="zshrc"
gitconfig="gitconfig"
dircolors="dir_colors"
ideavimrc="ideavimrc"

dir="${HOME}/"

targets=($vimdir $vimrc $gvimrc $tmuxconf $zshrc $gitconfig $dircolors $ideavimrc)

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
      makeSymLink "${dir}.${target}" "/${repodir}${target}"
    elif [ $1 = 'cleanup' -a -h "${dir}.${target}" ]; then
      rm -i $dir.$target
    fi
  done
}

vimenv() {
  basedir=$(dirname $0)
  if [ $# = 0 ]; then
    echo 'nomal setup'
  elif [ $1 = 'ruby' -a ! -f $basedir/gems/bin/refe ]; then
    echo 'setup with ruby refe'
    echo 'GEM_HOME set '. $basedir/gems
    which gem && GEM_HOME=$basedir/gems gem install refe2 
    test -f $basedir/gems/bin/bitclust && GEM_HOME=$basedir/gems $basedir/gems/bin/bitclust setup
  else
    echo 'Additional section : Nothing to do.'
  fi
  which git || yum install git -y
  test -d ~/.vim/bundle/vundle || git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  vim ~/.vimrc -c NeoBundleInstall
}

clone_dotfiles() {
  GIT=`which git`
  $GIT clone $repo $HOME/dotfiles
}

if [ -z "$1" ]; then
  echo -n "Check git command : "
  if ! which git; then
    echo "Please install git."
    exit 1
  fi
  repodir="dotfiles/"
  if [ -d $HOME/dotfiles ]; then
    echo "$HOME/dotfiles is already exists."
    exit 1
  fi
  clone_dotfiles && dotfiles && exit 0
fi

case "$1" in
vimenv)
vimenv $2 && exit 0
$1
;;
dotfiles)
dotfiles $2 && exit 0
$1
;;
*)
cat << EOS
Usage: $0 { dotfiles | dofiles cleanup | vimenv }

$0 dotfiles
  create dotfile symlinks

$0 ditfiles cleanup
  remove dotfile symlinks

$0 vimenv
  build vim enviroment and install plugins

$0 vimenv ruby
  build vim enviroment and install plugins with ruby refe
EOS
exit 2
esac
exit $?
