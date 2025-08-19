#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

#Pywal
(cat ~/.cache/wal/sequences &)

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Created by `pipx` on 2025-06-10 14:11:05
export PATH="$PATH:/home/sergio/.local/bin"
