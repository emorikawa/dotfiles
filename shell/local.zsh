##### GPG
ROBB_KEY=43705ADD
EVAN_KEY=21CCB5B8

##### General
alias c="cd ~/Code && ls"

##### Nylas
alias e="cd ~/Code/N1/build/resources/nylas && ls"
alias n="cd ~/Code/N1 && ls"
alias nd="cd ~/Code/N1 && ./N1.sh --dev --enable-logging"
alias n1="cd ~/Code/N1 && ./N1.sh --dev --enable-logging"
alias nt="cd ~/Code/N1 && ./N1.sh --test --enable-logging"
alias vu="cd ~/Code/sync-engine && vagrant up && vagrant ssh"
alias rw="cd ~/Code/share-redwood/redwood/web && mvim -O3 && cd ~/Code/share-redwood && source bin/activate && open http://localhost:7777 && INBOX_ENV=dev ./bin/start-web"
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
