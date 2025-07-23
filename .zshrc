export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="sunaku"
BRAIN="/home/miguel/Repos/itsorphic/brainz/"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Enviroment Variables
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#ccc'

# Aliases
alias python="python3"
alias pip="pip3"

alias e='exit'
alias c='clear'
alias t='tmux'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias bat='batcat --theme=gruvbox-dark'

alias brainz='cd $BRAIN && nvim .'

command -v batcat > /dev/null && alias cat='batcat --theme=gruvbox-dark'
command -v lsd > /dev/null && alias ls='lsd -l --group-dirs first'
command -v lsd > /dev/null && alias tree='lsd --tree'

# Keybinds
bindkey '^[[2~' overwrite-mode
bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[3;5~' kill-word
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history

alias cc="XDG_CURRENT_DESKTOP=GNOME gnome-control-center"

# Misc
unsetopt NO_BEEP
unsetopt NO_MATCH
setopt AUTO_CD
setopt BEEP
setopt NOMATCH
setopt NOTIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt HIST_BEEP
setopt INTERACTIVE_COMMENTS
setopt MAGIC_EQUAL_SUBST
setopt NULL_GLOB

