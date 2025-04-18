# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~
eval "$(ssh-agent -s)" > /dev/null 2>&1
ssh-add ~/.ssh/github-orphic > /dev/null 2>&1

# ~~~~~~~~~~~~ Environment Variables ~~~~~~~~~
export VISUAL=nvim
export EDITOR=nvim
export TERM=alacritty
export BROWSER=librewolf

# Directories
export REPOS="$HOME/Repos"
export GHREPOS="$REPOS/github.com"
export DOTFILES="$GHREPOS/.dotfiles"
export LAB="$GHREPOS/lab"
export BRAIN="$GHREPOS/brain"
export SCRIPTS="$DOTFILES/scripts"

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~
path=(
    $path
    $HOME/bin
    $HOME/.local/bin
    $SCRIPTS
)

# Remove duplicates
typeset -U path
path=($^path(N-/))

export PATH

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~
alias c='clear'
alias e='exit'
alias t='tmux'
alias v='nvim'
alias vim='nvim'
alias cat='bat'

alias scripts='cd $SCRIPTS'
alias dotfiles='cd $DOTFILES'
alias lab='cd $LAB'
alias repos='cd $REPOS'
alias brain='cd $BRAIN'
alias note='cd $BRAIN/0\ Inbox && vim .'

alias ls='lsd -l --icon=never'
alias la='lsd -lath --icon=never'
alias tree='lsd --tree --icon=never'

# finds all files recursively and sorts by last modification, ignore hidden files
alias lastmod='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias pacman='sudo pacman'
alias updateos='sudo pacman -Syu'

alias gc='git commit'
alias gp='git pull'
alias gs='git status'
