function collapse_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

PROMPT='❮%{$fg[green]%}%3~%{$reset_color%}❯ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}%{$reset_color%} '
VIM_PROMPT="%{$fg_bold[blue]%}🐙 %{$reset_color%}"
RPROMPT='${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} (${PWD/#$HOME/~} %* $(weather))'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
