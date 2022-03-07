echo "X$-" | grep -vq i && return

source $HOME/.grml_zshrc

### custom functions ###
# du
d() {
  du -ah $1 | tail -n 1
}

# xdg-open many files
oo() {
  (
  for item in $@; do
    xdg-open ${item}
  done
)
}

wait_loop() {
  local words=$1
  local sec=$2
  local cmd=$3
  echo -n "${words}."
  for i in $(seq 1 ${sec}); do
    sleep 1
    if [[ $((${i} % 6)) -lt 3 ]]; then
      echo -n '.'
    else
      echo -en "\b \b"
    fi
    eval "${cmd}" > /dev/null 2>&1
    if [[ $? == 0 ]]; then
      echo ''
      echo 'succeeded'
      return 0
    fi
  done
  echo ''
  echo 'failed'
  return 1
}

# connect a known SSID
nmc() {
  nmcli device wifi rescan
  local cmd=$(grep "nmcli d w c" ${HISTFILE} | cut -d ';' -f2 | grep "$1" | head -n 1)
  local ssid=$(echo ${cmd} | cut -d ' ' -f5- | rev | grep -oP '(?<=drowssap )[^*]*' | rev)
  if [[ -z ${ssid} ]]; then
    ssid=$(echo ${cmd} | cut -d ' ' -f5-)
  fi
  echo "SSID: ${ssid}"
  echo "password: ********"
  wait_loop 'trying to connect now' 15 "${cmd}"
}

# connect a new SSID
nmn() {
  echo -n 'SSID: '
  read ssid
  echo -n 'password: '
  read -s passwd
  echo ''
  nmcli device wifi rescan
  local cmd="nmcli d w c $(printf '%q' "${ssid}") password ${passwd}"
  wait_loop 'trying to connect now' 15 "${cmd}"
  ret=$?
  echo ": $(date +%s):${ret};${cmd}" >> ${HISTFILE}
}

# ranger
ra() {
  if [ -z "$RANGER_LEVEL" ]; then
    ranger
  else
    exit
  fi
}

# search history
hgrep() {
  if [ -z $@ ]; then
    echo 'please input your arguments' >&2
    return 1
  fi
  for str in $@; do
    grep ${str} ${HISTFILE} | awk -F ';' '{ print $2 }'
  done
}

# send notify while finishing a task
_prepare() {
  cmd_start_time="$SECONDS"
  if [[ -n "DISPLAY" ]]; then
    cmd_active_window=$(xdotool getactivewindow)
  fi
}

add-zsh-hook preexec _prepare

_finish_check() {
  local delta_time=$((SECONDS - cmd_start_time))
  ((sec=delta_time%60, min=delta_time/60, hrs=delta_time/3600))
  local time_info="total ${hrs}h ${min}m ${sec}s"
  local msg="$(fc -l | tail -n 1 | cut -d ' ' -f3-)
${time_info}"
  if [[ -n "$DISPLAY" ]]; then
    local active_window=$(xdotool getactivewindow 2> /dev/null)
    if [[ -n "${cmd_active_window}" && "${active_window}" != "$cmd_active_window" ]]; then
      notify-send -i '/usr/share/icons/Numix-Circle/48/apps/Terminal.svg' DONE "${msg}"
    fi
  fi
  [[ ${delta_time} -lt 10 ]] && return
  echo "${time_info}"
  return
}

add-zsh-hook precmd _finish_check

# starm ls
last_ls=$(command ls | base32)
last_pwd="$PWD"
_starm_ls() {
  local this_ls=$(command ls | base32)
  if [[ "$last_ls" != "$this_ls" || "$last_pwd" != "$PWD" ]]; then
    last_ls=$(command ls | base32)
    last_pwd="$PWD"
    if [[ $(command ls | command wc -l) -lt 32 ]]; then
      ls
    fi
  fi
}

add-zsh-hook precmd _starm_ls

# find file by mimetype
fm() {
  local mime="$1"
  fd -t f | parallel -j+1 file --mime-type | command grep --color=no "${mime}" | cut -d ':' -f1
}

# git clone
# defaultly, read url from clipboard
gcl() {
  if [[ -z $@ ]]; then
    git clone $(xclip -selection clipboard -o)
  else
    git clone $@
  fi
}

### customize the grml-zsh-config ###
zstyle ':prompt:grml:left:setup' items rc change-root path host time vcs newline percent
autoload -U colors && colors
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:*' unstagedstr '!'
  zstyle ':vcs_info:*' stagedstr '+'
  zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"

zstyle ':prompt:grml:right:setup' items sad-smiley battery

### plugins ###
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -n "$DISPLAY" ]; then
  source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
source "$HOME/.zsh/zsh-completions/zsh-completions.plugin.zsh"

### paths ###
export PATH="$PATH:$HOME/.local/bin/"
export PATH="$PATH:$HOME/.local/bin/openresty-systemtap-toolkit/"
export PATH="$PATH:$HOME/.local/bin/FlameGraph/"
export PATH="$PATH:$HOME/.arduino15/"

### default editor ###
export EDITOR=nvim

### proxychains4 ###
alias pc="proxychains4 -q -f $HOME/.proxychains.conf"

### aliases ###
# single character aliases
alias x='startx'
alias t='tmux'
alias o='xdg-open'
alias v='nvim'
alias h='hx'
alias l='ls'
alias c='clear'
alias s='setxkbmap -option ctrl:swapcaps'

# nvim no plugins
alias vi='nvim --noplugin'

# nmcli
alias nmr='nmcli d w r'

# git
alias gst='git status'
alias gck='git checkout'
alias grm='git rm'
alias gcm='git commit'
alias gps='git push'
alias gpl='git pull'
alias gfc='git fetch'

# cd tricks
alias ...='../..'
alias -- -='cd -'

# clip
alias xc='xclip -selection clipboard -i'

# python
alias py='python3 -q'

#tldr
alias zt='tldr -L zh'

# watch bilibili
alias wb="mpv --http-header-fields='referer:https://www.bilibili.com/&apos;,&apos;user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36'"

# sudo tricks
alias sudo='sudo '

# make
alias rmk='make clean && make'

# compile flags
alias cc='gcc -Wall -Werror -Wshadow -g -fsanitize=address -O0'
alias xx='g++ -Wall -Werror -Wshadow -g -fsanitize=address -O0'

# dnf
alias pd="sudo dnf -c $HOME/.dnf.conf"
alias din='sudo dnf install'
alias drm='sudo dnf remove'
alias dup='sudo dnf update'
alias dsc='sudo dnf search'

# be quiet
alias bc='bc -q'
alias gdb='gdb -q'
alias clisp='clisp -q'

# arduino-cli
alias al='arduino-cli'

# lazygit
alias lg='lazygit'

# ssh
alias ssh='TERM=xterm ssh'

# md
alias mkd='mkdir'

# trans
trans() {
  if [[ -z $1 ]]; then
    command trans en:zh -show-prompt-message Y -I
  else
    command trans en:zh $1
  fi
}
alias entrans='command trans'

md() {
  if [ -z "$2" ]; then
    mkdir "$1" || return
    cd "$1"
  else
    mkdir "$@"
  fi
}

eval "$(lua "$HOME/src/tools/z.lua/z.lua"  --init zsh once enhanced)"

## setup scripts ###
#if [ ! -f /tmp/auto_backlight.lock ]; then
#  nohup set_backlight > /dev/null 2>&1 &
#fi

### consolefonts setting ###
if [ $TERM = linux ]; then
  setfont /usr/share/consolefonts/Insonsolata/Inconsolata-32b.psf
fi

# perl
if command -v perl > /dev/null; then
  eval "$(perl -Mlocal::lib="$HOME"/.local)"
fi

#if [ $SHLVL -eq 1 ]; then
#  echo 'Login i3wm?'
#  read choice
#  [ -z "$choice" ] && startx
#fi
