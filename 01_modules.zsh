# modules - loading and configuration
#
# CopyLeft - Calogero Lo Leggio <kalos@nerdrug.org>


zmodload -i zsh/complist

#autoload -U colors
autoload zsh/terminfo colors
[[ "$terminfo[colors]" -ge 8 ]] && colors
eval `dircolors -b`

autoload run-help

#zmodload -e zsh/clone

#zftp
#autoload -U zfinit
#zfinit
