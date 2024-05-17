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
echo "--->  Linking .vimrc"
ln -sf $BASEDIR/vim/vimrc $HOME/.vimrc
echo "--->  Linking .vim folder"
ln -sf $BASEDIR/vim/vim $HOME/.vim
echo "--->  Installing latest vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "===>  Linking in gitconfig  <==="
echo "--->  Backing up any previous .gitconfig"
cp $HOME/.gitconfig $HOME/.gitconfig.bak
echo "--->  Linking .gitconfig"
ln -sf $BASEDIR/gitconfig $HOME/.gitconfig

# Installing zsh
echo ""
echo "===>  Installing zsh  <==="
brew install zsh
echo "--->  Making backup of zshrc"
cp $HOME/.zshrc $HOME/.zshrc.bak

echo "--->  Installing oh my zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clear home of any conflicting zsh files
rm -f $HOME/.zshrc

echo "--->  Linking zshrc"
ln -sf $BASEDIR/shell/zshrc $HOME/.zshrc

echo "--->  Installing customized theme"
cp $BASEDIR/shell/evan.zsh-theme ~/.oh-my-zsh/themes

echo "--->  Changing default shell to zsh"
IAM=`whoami`
sudo chsh -s `which zsh`
sudo chsh -s `which zsh` $IAM
/usr/bin/env zsh
source ~/.zshrc

echo ""
echo "====  Successfully installed Evan's environment  ===="
