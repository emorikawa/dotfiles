#!/usr/bin/env sh
if [ `whoami` == root ]; then
  echo "DONT run this script as root, or using sudo"
  exit
fi

echo ""
echo "*************************************"
echo "* Setting up ideal Unix environment *"
echo "*************************************"
echo ""

BASEDIR=$(cd "$(dirname "$0")"; pwd)

cd `dirname $0`

if [ "$(ls -A $BASEDIR/shell/oh-my-zsh)" ]; then
  echo "---> Git submodule found. Moving on"
else
  echo "---> ERROR: please do a git clone --recursive to grab the oh-my-zsh submodule"
  exit
fi

# Installing fonts
echo ""
echo "===>  Installing fonts  <==="
if [ -d "$HOME/Library/Fonts" ]; then
  sudo cp $BASEDIR/fonts/* $HOME/Library/Fonts
fi

if [ -d "/usr/local/share/fonts" ]; then
  sudo cp $BASEDIR/fonts/* /usr/share/fonts
fi

# Installing vim
# Ensuring required homebrew items installed
brew install vim # we need the non-system vim
brew install the_silver_searcher # to search faster and respect .gitignore
brew install fzf # an awesome file fuzzy-finder
brew install hub
brew install pyenv
brew install pyenv-virtualenv
$(brew --prefix)/opt/fzf/install  # adds cool command line integration
echo ""
echo "===>  Installing VIM  <==="
echo "--->  Backing up any previous .vimrc"
cp $HOME/.vimrc $HOME/.vimrc.bak
cp $HOME/.gvimrc $HOME/.gvimrc.bak
echo "--->  Linking .vimrc"
ln -sf $BASEDIR/vim/vimrc $HOME/.vimrc
echo "--->  Linking .gvimrc"
ln -sf $BASEDIR/vim/gvimrc $HOME/.gvimrc
echo "--->  Linking .vim folder"
ln -sf $BASEDIR/vim/vim $HOME/.vim
echo "--->  Installing latest vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "--->  Linking snips"
ln -sf $BASEDIR/vim/UltiSnips $HOME/.vim/UltiSnips

# Installing tmux
# echo ""
# echo "===>  Installing tmux <==="
# echo "--->  Making backup of .tmux.conf"
# cp $HOME/.tmux.conf $HOME/.tmux.conf.bak
# echo "--->  Linking .tmux.conf"
# ln -sf $BASEDIR/tmux/.tmux.conf $HOME/.tmux.conf
# echo "--->  Making backup of .tmux folder"
# mv -f $HOME/.tmux $HOME/.tmux_bak
# echo "--->  Linking .tmux folder"
# ln -sf $BASEDIR/tmux/.tmux $HOME/.tmux

# Installing zsh
echo ""
echo "===>  Installing zsh  <==="
brew install zsh
zshpath=$(which zsh)
if [ $? -eq 1 ]; then
  echo "XXX>  Please install zsh <XXX"
  echo "---> http://www.zsh.org/"
else
  echo "--->  Making backup of zshrc"
  cp $HOME/.zshrc $HOME/.zshrc.bak

  # Clear home of any conflicting zsh files
  rm -f $HOME/.zshrc
  rm -rf $HOME/.oh-my-zsh

  echo "--->  Linking zshrc"
  ln -sf $BASEDIR/shell/zshrc $HOME/.zshrc
  ln -sf $BASEDIR/shell/local.zsh $HOME/.local.zsh
  ln -sf $BASEDIR/shell/oh-my-zsh $HOME/.oh-my-zsh

  echo "--->  Installing weather plugin"
  # ln -sf $BASEDIR/shell/weather $HOME/.weather
  # if [[ -d $HOME/Library/LaunchAgents ]]; then
  #   cp $BASEDIR/shell/weather/e0m.weather.plist $HOME/Library/LaunchAgents
  # fi

  echo "--->  Installing customized theme"
  cp $BASEDIR/shell/evan.zsh-theme $BASEDIR/shell/oh-my-zsh/themes

  echo "--->  Changing default shell to zsh"
  IAM=`whoami`
  sudo chsh -s `which zsh`
  sudo chsh -s `which zsh` $IAM
  /usr/bin/env zsh
  source ~/.zshrc
fi

echo ""
echo "====  Successfully installed Evan's environment  ===="
