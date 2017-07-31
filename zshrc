# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Completion and custom prompt support
autoload -U compinit promptinit
compinit
promptinit

# Vim style key mappings
bindkey -v

# Ignore duplicates in history
setopt HIST_IGNORE_DUPS

# Because fuck typing "yaourt" every damn time i want to install something
alias yt=yaourt

# Make sure everybody knows terminator supports 256-colors
export TERM=xterm-256color

## Modified commands ## {{{
alias diff='colordiff'              # requires colordiff package
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping='ping -c 5'
alias dmesg='dmesg -HL'
# }}}

## New commands ## {{{
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep'         # requires an argument
alias openports='ss --all --numeric --processes --ipv4 --ipv6'
alias pgg='ps -Af | grep'           # requires an argument
alias ..='cd ..'
# }}}

# Privileged access
if [ $UID -ne 0 ]; then
    alias sudo='sudo '
    alias scat='sudo cat'
    alias svim='sudoedit'
    alias root='sudo -i'
    alias reboot='sudo systemctl reboot'
    alias poweroff='sudo systemctl poweroff'
    alias update='sudo pacman -Su'
    alias netctl='sudo netctl'
fi

## ls ## {{{
alias ls='ls -hFG'
alias lr='ls -R'                    # recursive ls
alias ll='ls -lha'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'
# }}}

# Up/down browses history (if field is empty), or searches (not empty)
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Custom prompt with colors (nvm, let prezto handle the prompts)
autoload -U colors && colors
#export PROMPT="%B%(?..[%?] )%b%n@%m %{$fg[cyan]%}%~%{$reset_color%}>"
