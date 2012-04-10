# Evan's Crafting Bench (aka dotfiles)
Configuration and setup for the tools and utilities I use regularly.

- vim
- tmux
- zsh
- typography

## Installation
Simply run ./install

This take-anywhere configuration works on Linux and Mac OSX
The installation will:
- Install key software using either apt-get or mac-ports
- Install a tweaked out vim
- Install zsh
- Symlink dotfiles to this directory

## vim
Make sure the vim folder is symlinked to ~/.vim and vimrc is symlinked to ~/.vimrc

I use [Vundle](https://github.com/gmarik/vundle) to manage vim packages. Check out the list of packages at the start of the vimrc file. Some categorized packages I use include:

### Helps me read
- **[Powerline](https://github.com/Lokaltog/vim-powerline):** Souped-up satus line
- **[CSS Color](https://github.com/skammer/vim-css-color):** Colored hex codes in CSS/LESS files
- **[CSS3 Syntax](https://github.com/hail2u/vim-css3-syntax):** CSS3 syntax highlighting
- **[HAML SASS SCSS](https://github.com/tpope/vim-haml):** HAML, Sass, and Scss sytax highlighting
- **[Less](https://github.com/groenewege/vim-less):** Less syntax highlighting
- **[Coffeescript](https://github.com/kchmck/vim-coffee-script):** Coffeescript support for vim
- **[Markdown](https://github.com/plasticboy/vim-markdown):** Markdown syntax highlighting

### Helps me move
- **[NerdTree](https://github.com/scrooloose/nerdtree):** File explorer in vim
- **[Rails](https://github.com/tpope/vim-rails):** Ruby on Rails power tools
- **[Matchit](https://github.com/tsaleh/vim-matchit):** Extends % operator to match html and others

### Helps me type
- **[Surround](https://github.com/tpope/vim-surround):** Surround text easily
- **[Repeat](https://github.com/tpope/vim-repeat):** Repeats complex commands like regular ones
- **[Snipmate](https://github.com/msanders/snipmate.vim):** Easy auto-filling snippets
- **[Sparkup](https://github.com/rstacruz/sparkup):** Super fast html writing
- **[TComment](https://github.com/tomtom/tcommentvim):** Comment in and out lines
- **[EasyMotion](https://github.com/Lokaltog/vim-easymotion):** Motions on speed. Replaces <number> in <number><motion>

### Helps me collaborate
- **[Fugitive](https://github.com/tpope/vim-fugitive):** Awesome git wrapper

## tmux
(Readme coming soon)

## zsh
(Readme coming soon)

## Typography
(Readme coming soon)
