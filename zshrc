#set -x

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bira"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
#DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git archlinux tmux gitignore github sudo pass pipenv docker
)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
alias vim="nvim"
alias pping="prettyping --nolegend"
alias top="htop"
#alias diff="diff-so-fancy"
alias du="ncdu --color dark -x --exclude .git --exclude node_modules" 
alias help="tldr"

alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
alias l='ls -l'
alias ll='ls -la'
alias ipython='python -m IPython'

#TODO check the operating system to decide which upgrade alias to use
alias upgrade='yay -Syu'
# alias upgrade='sudo apt-get update && sudo apt-get dist-upgrade'

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

# usuall path for user binaries
# Python is using this directory
if [[ -d $HOME/.local/bin ]]; then
  export PATH=$HOME/.local/bin:$PATH
fi

if [[ -d $HOME/.poetry/bin ]]; then
  export PATH="$HOME/.poetry/bin:$PATH"
fi

# Default location for Rust Apps
if [[ -d $HOME/.cargo/bin ]]; then
  export PATH=$HOME/.cargo/bin:$PATH
fi

# Path for custom scripts
if [[ -d $HOME/bin ]]; then 
  export PATH=$HOME/bin:$PATH
fi

# Path for flutter
if [[ -d $HOME/.local/opt/flutter/bin ]]; then 
  export PATH=$HOME/.local/opt/flutter/bin:$PATH
fi

# Path for Chia Plotter (self compiled)
if [[ -d $HOME/Developer/chia-plotter/build ]]; then
  export PATH=$HOME/Developer/chia-plotter/build:$PATH
fi

# GoogleChrome VARIABLE required for flutter
if [[ -f /usr/bin/google-chrome-stable ]]; then
  export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
fi

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/my-functions.sh

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# export DEATHSTAR=lfxaryuhbcdfabp7.onion

if [[ -d $HOME/.config/broot ]]; then
  source $HOME/.config/broot/launcher/bash/br
fi

if [[ -e $HOME/.xprofile ]]; then
  source $HOME/.xprofile
fi

if [[ -d $HOME/Android/Sdk ]]; then
  export ANDROID_HOME=$HOME/Android/Sdk
  export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin
fi

# GoogleChrome VARIABLE required for flutter
if [[ -e /usr/bin/google-chrome-stable ]]; then
  export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
fi

# Path for flutter
if [[ -d $HOME/.local/opt/flutter/bin ]]; then 
  export PATH=$HOME/.local/opt/flutter/bin:$PATH
fi

# Starship Shell Prompt
if [[ -e $HOME/.cargo/bin/starship ]]; then
  eval "$(starship init zsh)"
fi

chia-start-all-if-needed

