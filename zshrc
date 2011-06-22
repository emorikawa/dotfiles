# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git macports osx pip)

source $ZSH/oh-my-zsh.sh

#alias ls='ls -G'
alias ll='ls -la -G'
alias su2='cd ~/su2/infrastructure; ls -G'

EVANKEY=21CCB5B8
RAEEZKEY=6F2F2AE8

SH_ENV="$HOME/.ssh/environment"

# start the ssh-agent
function start_agent {
  echo "Initializing new SSH agent..."
  # spawn ssh-agent
  ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
  echo succeeded
  chmod 600 "$SSH_ENV"
  . "$SSH_ENV" > /dev/null
  ssh-add
}

# test for identities
function test_identities {
  # test whether standard identities have been added to the agent already
  ssh-add -l | grep "The agent has no identities" > /dev/null
  if [ $? -eq 0 ]; then
    ssh-add
    # $SSH_AUTH_SOCK broken so we start a new proper agent

    if [ $? -eq 2 ];then
      start_agent
    fi
  fi
}

# check for running ssh-agent with proper $SSH_AGENT_PID
if [ -n "$SSH_AGENT_PID" ]; then
  ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
  if [ $? -eq 0 ]; then
    test_identities
  fi
  # if $SSH_AGENT_PID is not properly set, we might be able to load one from
  # $SSH_ENV
else
  if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
  fi

  ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null

  if [ $? -eq 0 ]; then
    test_identities
  else
    start_agent
  fi

fi

export PATH=/opt/local/bin:/opt/local/sbin:$HOME/local/node/bin:$PATH
