# zsh command line editor
#
# CopyLeft - Calogero Lo Leggio <kalos@nerdrug.org>

# { zle options

  # Choose word delimiter characters in line editor
  WORDCHARS="*?_-.[]~/&;!#$%^(){}<>" # part of word in line editor

unsetopt beep                 # no beep me please
unsetopt overstrike           # dont start le in overstrike mode
unsetopt single_line_zle      # use multiline editor
  setopt zle                  # use zsh le
# } 


## { vi keybindings
#bindkey -v
#
#bindkey -M vicmd "^R" redo
#bindkey -M vicmd "u" undo
#bindkey -M vicmd "ga" what-cursor-position
## }

bindkey -e

# { standard
bindkey "$terminfo[kdch1]"  delete-char                         # Delete
bindkey "\e[3~"             delete-char                         # Delete
bindkey "$terminfo[khome]"  beginning-of-line                   # Home
bindkey "\e[1~"             beginning-of-line                   # Home
bindkey "^[[7~"             beginning-of-line                   # Home (xterm)
bindkey "\eOH"              beginning-of-line                   # Home (debian xterm)
bindkey "\e[7~"             beginning-of-line                   # Home (rxvt)
bindkey "\e[H"              beginning-of-line                   # Home (BSD)
bindkey "$terminfo[kend]"   end-of-line                         # End
bindkey "\e[4~"             end-of-line                         # End
bindkey "^[[8~"             end-of-line                         # End (xterm)
bindkey "\eOF"              end-of-line                         # End (debian xterm)
bindkey "\e[8~"             end-of-line                         # End (rxvt)
bindkey "\e[F"              end-of-line                         # End (BSD)
bindkey "$terminfo[kcuu1]"  history-beginning-search-backward   # Page Up
#bindkey "$terminfo[cuu1]"   history-beginning-search-backward   # Page Up
bindkey "^[[5~"             history-beginning-search-backward   # Page Up
bindkey "\e[5~"             history-beginning-search-backward   # Page Up
bindkey "$terminfo[kcud1]"  history-beginning-search-forward    # Page Down
#bindkey "$terminfo[cud1]"   history-beginning-search-forward    # Page Down
bindkey "\e[6~"             history-beginning-search-forward    # Page Down
bindkey "$terminfo[kich1]"  overwrite-mode                      # Insert
bindkey "^[[2~"             overwrite-mode                      # Insert
bindkey "\e[2~"             overwrite-mode                      # Insert

bindkey "^[[A"              up-history                          # UP arrow for back-history
bindkey "^[[B"              down-history                        # DOWN arrow for fwd-history
#bindkey "^[[A"              up-line-or-search                   # UP arrow for back-history-search
#bindkey "^[[B"              down-line-or-search                 # DOWN arrow for fwd-history-search
#bindkey "^F"                history-incremental-search-backward # ALT-R - history search
bindkey "^[r"               history-incremental-search-backward # ALT-R - history search
bindkey " "                 magic-space                         # ' ' (Space)
# }

# { (u)rxvt compatibily
bindkey "\e[\304"           backward-word                       # rxvt M-left
bindkey "\eOd"              backward-word                       # rxvt C-left
bindkey "\e[\303"           forward-word                        # rxvt M-right
bindkey "\eOc"              forward-word                        # rxvt C-right
bindkey "\e[\301"           beginning-of-line                   # rxvt M-up
bindkey "\e[\302"           end-of-line                         # rxvt M-down
#bindkey '\e[3\376'  delete-word   # rxvt M-delete
# }

# { movement
bindkey "^[z"               backward-word                       # ALT-Z
bindkey "^[x"               forward-word                        # ALT-X
bindkey "^[c"               vi-backward-word                    # ALT-C
bindkey "^[v"               vi-forward-word                     # ALT-V
bindkey "^[a"               vi-backward-kill-word               # ALT-A
bindkey "^[s"               delete-word                         # ALT-S
bindkey "^[q"               backward-kill-line                  # ALT-Q
bindkey "^[w"               kill-line                           # ALT-W
# }

# { menuselect
#bindkey -N menuselect
bindkey -M menuselect  "$terminfo[kcuu1]"  up-history
bindkey -M menuselect  "$terminfo[kcud1]"  down-history
bindkey -M menuselect  "$terminfo[khome]"  beginning-of-history
bindkey -M menuselect  "$terminfo[kend]"   end-of-history
bindkey -M menuselect  "$terminfo[kcuu1]"  beginning-of-line-hist
bindkey -M menuselect  "$terminfo[kcud1]"  end-of-line-hist
bindkey -M menuselect  "^[[A"  up-history
bindkey -M menuselect  "^[[B"  down-history
bindkey -M menuselect  "^[[H"  beginning-of-history
bindkey -M menuselect  "^[[F"  end-of-history
bindkey -M menuselect  "^[[5~" beginning-of-line-hist
bindkey -M menuselect  "^[[6~" end-of-line-hist

bindkey -M menuselect 'i' accept-and-menu-complete
#bindkey -M menuselect 'o' accept-and-infer-next-history
# }

# { misc
bindkey "$terminfo[kf1]"    run-help                            # F1
bindkey "$terminfo[kf2]"    which-command                       # F2
bindkey "^[OP"              run-help                            # F1
bindkey "^[OQ"              which-command                       # F2
bindkey "^Q"                quote-line                          # CTRL-Q
#bindkey "^[e"               undo                                # ALT-E
#bindkey "^[r"               redo                                # ALT-R
bindkey "^[^[[A"            up-case-word                        # ALT-UP
bindkey "^[^[[B"            down-case-word                      # ALT-DOWN
bindkey "\eOa"              vi-swap-case                        # CTRL-UP
bindkey "\eOb"              vi-swap-case                        # CTRL-DOWN

bindkey "^t"                run-with-sudo
bindkey "^[p"               run-ps
bindkey "^v"                edit_command_line
bindkey "^l"                clear-term
bindkey "^e1"               __jump_behind_first_word

bindkey -s "^r"             "sudo -i\n"
bindkey -s "^[n"            "netstat -ltupn\n"
#bindkey -s "^k"             "cd ~L && make menuconfig\n"

#bindkey '\C-v' paste-xclip
# bindkey -s secret 'Oh no!'
#
# ^[^i == CTRL+ALT+i
# }


# { zle
run-with-sudo () {
#  [[ -z $BUFFER ]] && zle up-history
  [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
}
zle -N run-with-sudo

run-ps () {
  zle -I
#  ps axfww
  ps x --forest -wwwA -o pid,user,cmd #-u $USER
#  zle redisplay
}
zle -N run-ps

edit_command_line () {
  # edit current line in $EDITOR
  local tmpfile=${TMPPREFIX:-/tmp/zsh}ecl$$

  print -R - "$PREBUFFER$BUFFER" >$tmpfile
  exec </dev/tty
  ${VISUAL:-${EDITOR:-vi}} $tmpfile
  zle kill-buffer
  BUFFER=${"$(<$tmpfile)"/$PREBUFFER/}
  CURSOR=$#BUFFER

  command rm -f $tmpfile
  zle redisplay
}
zle -N edit_command_line

function __jump_behind_first_word() {
  local words
  words=(${(z)BUFFER})
  
  if (( ${#words} <= 1 )) ; then
    CURSOR=${#BUFFER}
  else
    CURSOR=${#${words[1]}}
  fi
}
zle -N __jump_behind_first_word

clear-term () {
  zle -I
  echo -ne '\033c'
}
zle -N clear-term


#paste-xclip() {
#  BUFFER=$BUFFER"`xclip -o`"
#  zle end-of-line
#}
#zle -N paste-xclip
# }
