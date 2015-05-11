##### GPG
ROBB_KEY=43705ADD
EVAN_KEY=21CCB5B8

##### General
alias c="cd ~/Code && ls"

##### Nylas
export EDGEHILL_PATH="/Users/evanmorikawa/Code/edgehill"
alias e="cd ~/Code/edgehill && ls"
alias ee="cd ~/Code/edgehill && edgehill --dev"
alias et="cd ~/Code/edgehill && edgehill --test"
alias vpn="gpg -d ~/.inbox-vpn.gpg | less"
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
# source $HOME/Code/arcanist/resources/shell/bash-completion

##### Proximate
alias p="cd ~/Code/proximate && ls"
alias console='cd ~/Code/Proximate && \
               heroku run rails console -a proximate-production'
alias useproddb='gpg -d -o config/database.yml config/database-prod.yml.gpg'
alias usedevdb='gpg -d -o config/database.yml config/database-dev.yml.gpg'
alias prodconsole='gpg -d -o config/database.yml config/database-prod.yml.gpg && rails console; -d -o config/database.yml config/database-dev.yml.gpg'

alias f='foreman start -f Procfile.dev'
alias rc='rails console'
