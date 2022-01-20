#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# exec fish

source /home/flo/.config/broot/launcher/bash/br

eval "$(starship init bash)"
