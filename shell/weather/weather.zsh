# A plugin that grabs and displays the weather.
# See the weather folder.
# Expects the current_weather file to be filled with the text
weather()
{
  if [[ -s $HOME/.weather/current_weather ]]; then
    w=$(cat $HOME/.weather/current_weather)
    if [[ -z "$w" ]]; then
      echo -ne ""
    else
      temp=$(cut -d ° -f1 ~/.weather/current_weather | awk '{ print $NF}')

      color="%{$fg_bold[white]%}"
      if [[ $temp -gt 38 ]]; then
        color="%{$fg_bold[magenta]%}"
      elif [[ $temp -gt 29 && $temp -le 38 ]]; then
        color="%{$fg_bold[red]%}"
      elif [[ $temp -gt 24 && $temp -le 29 ]]; then
        color="%{$fg_bold[red]%}"
      elif [[ $temp -gt 18 && $temp -le 24 ]]; then
        color="%{$fg_bold[yellow]%}"
      elif [[ $temp -gt 10 && $temp -le 18 ]]; then
        color="%{$fg_bold[green]%}"
      elif [[ $temp -gt 2 && $temp -le 10 ]]; then
        color="%{$fg_no_bold[green]%}"
      elif [[ $temp -gt "-8" && $temp -le 2 ]]; then
        color="%{$fg_no_bold[cyan]%}"
      elif [[ $temp -gt "-13" && $temp -le "-8" ]]; then
        color="%{$fg_bold[cyan]%}"
      elif [[ $temp -le "-13" ]]; then
        color="%{$fg_bold[blue]%}"
      fi
      echo -ne "${color}${w}%{$reset_color%}"
    fi
  else
    echo -ne ""
  fi
}
