# zsh completion system
#
# CopyLeft - Calogero Lo Leggio <kalos@nerdrug.org>


# { completion
  setopt always_to_end        # always go to end of word after completion
unsetopt autoname_dirs        # after foo=/absolute/path, ~foo may expand to
                              # /absolute/path, but `%~' in prompt won't give
                              # `~foo' until `~foo' has been used (rtfm closely)
  setopt auto_param_keys      # remove trailing spaces after completion if needed
  setopt auto_param_slash     # add slash for directories
unsetopt auto_remove_slash    # don't remove slash on dirs if word separator added
unsetopt bash_auto_list       # auto_list is sufficient, i want it on first tab
  setopt complete_in_word     # we want completion to be done from cursor in word
unsetopt glob_complete        # don't generate matches and cycle through them
  setopt hash_list_all        # verify path hash on completion
  setopt list_ambiguous       # unambiguous prefix completion is done silently
unsetopt list_beep            # don't beep for completion
  setopt list_packed          # different width for completion
unsetopt list_rows_first      # sort by colums
  setopt list_types           # show types of listing files
unsetopt menu_complete        # don't show menu on ambiguous completion
unsetopt rec_exact            # recognize exact match even if ambiguous
# }



# :completion:<func>:<completer>:<command>:<argument>:<tag>

zstyle ':completion:*' add-space true
#zstyle ':completion:*' completer _force_rehash _complete _approximate _prefix
zstyle ':completion:*' completer _expand _force_rehash _complete _match _approximate _prefix _list

#zstyle ':completion:*' cache-path ~/.zsh/cache
#zstyle ':completion:*' use-cache on

zstyle ':completion:*' expand true
zstyle ':completion:*' file-sort name
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ${(s.:.)ZLS_COLORS}
zstyle ':completion:*:processes' list-colors '=(#b)( #[0-9]#)[^[/0-9a-zA-Z]#(*)=34=37;1=30;1'
#zstyle ':completion:*' matcher-list 'r:|[._-]=** r:|=**' 'l:|=** r:|=**'
zstyle ':completion:*' menu select=2

zstyle ':completion:*' select-prompt %SScrolling active: current selection at %P Lines: %m
zstyle ':completion:*' squeeze-slashes true


zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete

#zstyle ':completion:*:approximate:*' max-errors 2
zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'


# start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:correct:*'       insert-unambiguous true

# Include non-hidden directories in globbed file completions
# for certain commands
#zstyle ':completion::complete:*' '\'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

#  tag-order 'globbed-files directories' all-files 
zstyle ':completion::complete:*:tar:directories' file-patterns '*~.*(-/)'

# Don't complete backup files as executables
#zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
#zstyle ':completion:*:-command-:*:'    verbose false


# Describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# { formats
#zstyle ':completion:*' group 1
#zstyle ':completion:*' format '%B---- %d%b'

#zstyle ':completion:*:corrections' format '%B---- %d (errors %e)%b'
#zstyle ':completion:*:descriptions' format "%B---- %d%b"
#zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
#zstyle ':completion:*:warnings' format "%B$fg[red]%}---- no match for: $fg[white]%d%b"

zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%}'
zstyle ':completion:*:descriptions' format $'%{\e[0;33m%}%d:%{\e[0m%}'
zstyle ':completion:*:messages' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for: %d%{\e[0m%}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-separator '#'
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# separate matches into groups
zstyle ':completion:*:matches' group 'yes'
# }

# { kill
#zstyle ':completion:*:processes' command 'ps -au$USER -o pid,time,cmd|grep -v "ps -au$USER -o pid,time,cmd"'
#zstyle ':completion:*:processes' command 'ps --forest -au$USER -o pid,time,cmd|grep -v "ps --forrest -au$USER -o pid,time,cmd"'
zstyle ':completion:*:*:*:*:processes' command 'ps --forest -au$USER -o pid,time,cmd|grep -v "ps --forrest -au$USER -o pid,time,cmd"'
#zstyle ':completion:*:processes' command ps --forest -A -o pid,user,cmd #-u $USER
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)[ 0-9:]#([^ ]#)*=01;30=01;31=01;38'
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:(pkill|kill):*' menu yes select
zstyle ':completion:*:kill:*' force-list always
# }

# { manuals
# complete manual by their section
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select
# }

# { history
#zstyle ':completion:*:history-words' stop yes
#zstyle ':completion:*:history-words' stop verbose
zstyle ':completion:*:history-words' remove-all-dups yes
###zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
# }

# { hosts and users
#hosts=()
#[ -r ~/.ssh/config ] && hosts=(${${${$(grep '^Host' ~/.ssh/config)}##Host }##[*0-9]*})
#[ -r ~/.ssh/known_hosts ] && hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%\*}%,*})
hosts=($((
        ( [ -r .ssh/config ] && awk '/^host +[a-z]/ { print $2 }' .ssh/config) ;\
        ( [ -r .ssh/known_hosts ] && awk '{print $1}' .ssh/known_hosts | tr , '\n')
) | sort -u))

zstyle ':completion:*' hosts $hosts
zstyle ':completion:*:hosts' list-colors '=(#b)(*)(.jukie.net)=01;30=01;31' '=[^.]#=01;31'

# SSH Completion
#zstyle ':completion:*:scp:*' tag-order \
#   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
#zstyle ':completion:*:scp:*' group-order \
#   files all-files users hosts-domain hosts-host hosts-ipaddr
#zstyle ':completion:*:ssh:*' tag-order \
#   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
#zstyle ':completion:*:ssh:*' group-order \
#   hosts-domain hosts-host users hosts-ipaddr
#zstyle '*' single-ignored show

#zstyle -e ':completion:*:(ssh|scp):*' hosts 'reply=(
#          ${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) \
#                          /dev/null)"}%%[# ]*}//,/ }
#          ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
#          ${${${(M)${(s:# :)${(zj:# :)${(Lf)"$([[ -f ~/.ssh/config ]] && <~/.ssh/config)"}%%\#*}}##host(|name) *}#host(|name) }/\*}
#          )'

users=(root kalos)
zstyle ':completion:*:(ssh|scp):*' users $users
# }

# { forcing the rehash
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1
}
# }

# { ignores for vim
zstyle ':completion:*:*:vi(m|):*:*files' ignored-patterns '*?.(aux|dvi|ps|pdf|bbl|toc|lot|lof|o|cm?)'
# }

# { misc
zstyle ':completion:*:*:[ak]dvi:*' file-patterns \
    '*.dvi:dvi-files:DVI\ files *(-/):directories:Directories' '*:all-files'
zstyle ':completion:*:*:kghostview:*' file-patterns \
    '*.(ps|pdf)(|.gz|.bz2):pspdf-files:PostScript\ or\ PDF\ files  *(-/):directories:Directories' '*:all-files'
zstyle ':completion:*:*:swfplayer:*' file-patterns \
    '*.swf:swf-files:Swf\ files  *(-/):directories:Directories' '*:all-files'

zstyle ':completion:*' file-patterns \
    '%p:globbed-files: *(-/):directories:Directories' '*:all-files'
# }
