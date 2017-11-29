##### GPG
EVAN_KEY=21CCB5B8

##### General
alias c="cd ~/Code && ls"

##### Nylas
alias n="cd ~/Code/nylas-mail-all && ls"
alias n1="cd ~/Code/nylas-mail-all && npm start"
alias nt="cd ~/Code/nylas-mail-all && npm test"
alias nc="cd ~/Code/nylas-mail-all && npm run start-cloud"
alias vu="cd ~/Code/sync-engine && vagrant up && vagrant ssh"
alias vpn="gpg -d ~/.inbox-vpn.gpg | less"
alias ol="gpg -d ~/.outlook-pass.gpg | less"
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
source ~/Code/git-subrepo/.rc
