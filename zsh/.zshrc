echo "X$-" | grep -vq i && return

source "$HOME/.grml_zshrc"

# avoid url being misunderstood
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

### custom functions ###

# glow to render markdown doc
mdless() {
  glow -w $(($(tput cols) / 10 * 10)) -s dark "$1" | less -r
}

# fedora paste
fp() {
  if [[ -n "$1" && -f "$1" ]]; then
    cat "$1" | fpaste -t "$(basename $1)"
  else
    fpaste
  fi
}

# show time table
tt() {
  for i in ~/.time_table/*; do
    cat "$i" || continue
  done
}

# grep
g() {
  grep "$@" -r ./*
}

# du
d() {
  for i in $@; do
    du -sh "$i"
  done
}

# xdg-open many files
o() {
  for item in $@; do
    xdg-open "$item" & disown
  done
}

mntu() {
  udisksctl mount --block-device "$@" || return 1
  echo "ln -sf /run/media/$(whoami)/* $HOME/src/media/"
  ln -sf /run/media/$(whoami)/* ~/src/media/
}

umntu() {
  udisksctl unmount --block-device "$@" || return 1
  for i in ~/src/media/*; do
    if [[ ! -e "$i" ]]; then
      rm "$i"
    fi
  done
}

# send notify while finishing a task
_prepare() {
  cmd_start_time="$SECONDS"
  last_cmd="$1"
  if [[ -n "DISPLAY" ]]; then
    cmd_active_window=$(xdotool getactivewindow)
  fi
}

add-zsh-hook preexec _prepare

_finish_check() {
  local ret="$?"
  local delta_time=$((SECONDS - cmd_start_time))
  ((sec=delta_time%60, min=delta_time/60, hrs=delta_time/3600))
  local time_info="total ${hrs}h ${min}m ${sec}s"
  local msg="  $last_cmd
${time_info}"
  if [[ -n "$DISPLAY" ]]; then
    local active_window=$(xdotool getactivewindow 2> /dev/null)
    if [[ -n "${cmd_active_window}" && "${active_window}" != "$cmd_active_window" ]]; then
      if [[ "$ret" -eq 0 ]]; then
        notify-send -u normal DONE "${msg}"
      else
        notify-send -u critical FAILED "${msg}"
      fi
    fi
  fi
  [[ ${delta_time} -lt 10 ]] && return
  echo "${time_info}"
  return
}

add-zsh-hook precmd _finish_check

# smart ls
last_ls=$(command ls | base32)
last_pwd="$PWD"
_starm_ls() {
  local this_ls=$(command ls | base32)
  if [[ "$last_ls" != "$this_ls" || "$last_pwd" != "$PWD" ]]; then
    last_ls=$(command ls | base32)
    last_pwd="$PWD"
    if [[ $(command ls | command wc -l) -lt 32 ]]; then
      exa
    fi
  fi
}

add-zsh-hook precmd _starm_ls

# find file by mimetype
fm() {
  local mime="$1"
  fd -t f | parallel -j+1 file --mime-type | command grep --color=no "${mime}" | cut -d ':' -f1
}

# md2pdf
md2pdf() {
  pandoc --pdf-engine=xelatex -V CJKmainfont="WenQuanYi Zen Hei" "$@"
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

masm() {
  local src="$1"
  cp "$src" ~/src/labs/dos-asm/masm/ || return 1
  local base="$(basename "$src" .asm)"
  dosbox \
    -c 'mount c ~/src/labs/dos-asm/masm' \
    -c 'c:' \
    -c "masm $base.asm" \
    -c "link $base.obj" \
    -c "cls" \
    -c ".\\$base.exe" \
    -c 'pause' \
    -c "del $base.asm" \
    -c "del $base.obj" \
    -c "del $base.exe" \
    -c 'exit' 2>/dev/null
}

# save the screen shot
save_shot() {
  [[ "$#" -eq 1 ]] || return 1
  xclip -selection clipboard -t image/png -o > "$1"
}

# run asm
asmc() {
  local base="$(basename "$1" .asm)"
  nasm -f elf32 "$base.asm"
  gcc -m32 "$base.o" -o "$base"
  "./$base"
  local ret="$?"
  rm "$base" "$base.o"
  return ret
}

md() {
  if [ -z "$2" ]; then
    mkdir "$1" || return
    cd "$1"
  else
    mkdir "$@"
  fi
}

# edit scripts in path
wv() {
  nvim $(which $@)
}

### customize the grml-zsh-config ###
zstyle ':prompt:grml:left:setup' items rc change-root path vcs newline jobs
autoload -U colors && colors
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:*' unstagedstr '!'
  zstyle ':vcs_info:*' stagedstr '+'
  zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"

zstyle ':prompt:grml:right:setup' items sad-smiley

### plugins ###
source ~/.zsh/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh
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

### default editor ###
export EDITOR=nvim

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

### pdf viewer
alias za=zathura

### proxychains4 ###
alias pc="proxychains4 -q -f $HOME/.proxychains.conf"

# safety
alias mv='mv -i'

### aliases ###
# single character aliases
alias t='tmux'
alias v='nvim'
alias h='hx'
alias l='exa'
alias c='clear'
alias s='setxkbmap -option ctrl:swapcaps'
alias n='neofetch'

alias unkeymap='setxkbmap -option'

# exa
alias ls='exa'
alias ll='exa -l'
alias la='exa -a'
alias lm='exa -m'

# lf
alias lf='lfub'

# qrcp
alias qr='qrcp --port 8888 --path vd --zip'

# disassembly
alias objdump='objdump --disassembler-options=intel'

# rmall - a self-made dictionary
alias rl='rmall -L'

# weather
alias weather='curl v2.wttr.in/wuhan'
alias wea='curl "wttr.in/wuhan?format=%C+%t+%p\n"'

# nvim no plugins
alias vi='nvim --noplugin'

# nvim split
alias vs='nvim -O'

# nmcli
alias nmr='nmcli d w r'

# git
alias gst='git status'
alias gck='git checkout'
alias grm='git rm'
alias gmv='git mv'
alias gcm='git commit'
alias gps='git push'
alias gpl='git pull'
alias gfc='git fetch'
alias glg='git log'

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
alias clx='clang++ -std=c++2a -Wall -Werror -Wshadow -g -fsanitize=address -O0'
alias c2asm='gcc -fomit-frame-pointer -fverbose-asm -O0 -masm=intel -S'

# dnf
alias din='sudo dnf install'
alias drm='sudo dnf remove'
alias dup='sudo dnf update'
alias dsc='sudo dnf search'

# be quiet
alias bc='bc -lq'
alias gdb='gdb -q'
alias clisp='clisp -q'

# arduino-cli
alias al='arduino-cli'

# lazygit
alias lg='lazygit'

# sleep
alias disslp='sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target'
alias enslp='sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target'

# proxy
alias proxy='export http_proxy="http://127.0.0.1:7890"; export https_proxy="http://127.0.0.1:7890"'
alias unproxy='unset http_proxy; unset https_proxy'

# md
alias mkd='mkdir'

# z.lua
eval "$(lua "$HOME/.zsh/z.lua"  --init zsh once enhanced)"
alias zz='z -c'      # restrict matches to subdirs of $PWD
alias zi='z -i'      # cd with interactive selection
alias zf='z -I'      # use fzf to select in multiple matches
alias zb='z -b'      # quickly cd to the parent directory

### consolefonts setting ###
if [ $TERM = linux ]; then
  setfont /usr/share/consolefonts/Insonsolata/Inconsolata-32b.psf
fi
