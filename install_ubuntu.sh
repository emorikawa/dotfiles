# Evan's installation for Ubuntu machines
# Last done on Ubuntu 22.04 for ML work
# BEFORE SCRIPT:
# - Install Chrome
# - Install 1Password
# - Install VSCode
# sudo apt update && sudo apt install curl git

# Commands for installing nvidia drivers:
# sudo add-apt-repository ppa:graphics-drivers/ppa
# sudo apt update
# sudo apt install nvidia-driver-550
# sudo reboot
#### On some machines, you must Enroll MOK after first reboot

set -e

if [ ! -f ~/.bashrc.bak ]; then
    mv ~/.bashrc ~/.bashrc.bak
    echo "Moved existing ~/.bashrc to ~/.bashrc.bak"
else
    echo "Backup already exists at ~/.bashrc.bak"
fi

if [ ! -L ~/.bashrc ]; then
    ln -s $(pwd)/shell/bashrc ~/.bashrc
    echo "Created symbolic link ~/.bashrc -> $(pwd)/shell/bashrc"
else
    echo "Symbolic link ~/.bashrc already exists"
fi

if [ ! -L ~/.bash_profile ]; then
    ln -s $(pwd)/shell/bash_profile ~/.bash_profile
    echo "Created symbolic link ~/.bash_profile -> $(pwd)/shell/bash_profile"
else
    echo "Symbolic link ~/.bash_profile already exists"
fi

# Required for python building
sudo apt update && sudo apt install -y \
  build-essential \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  wget \
  xz-utils \
  tk-dev \
  libffi-dev \
  liblzma-dev

# pyenv install:
if [ ! -d "$HOME/.pyenv" ]; then
  echo "Install pyenv"
  curl https://pyenv.run | bash
fi

source ~/.bashrc

which pyenv

pyenv install 3.10.14
