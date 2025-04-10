#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

#Auto hyprland select
if uwsm check may-start; then
	exec uwsm start hyprland.desktop
fi

#Pywal
(cat ~/.cache/wal/sequences &)
