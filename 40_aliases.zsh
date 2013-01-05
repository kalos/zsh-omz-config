# aliases
#
# CopyLeft - Calogero Lo Leggio <kalos@nerdrug.org>


# { basic
#alias .="pwd"
alias -- -="cd -"
alias ..='cd ..'
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
# }

# { redirections & pipes
alias -g N="&>/dev/null"
alias -g 1N="1>/dev/null"
alias -g 2N="2>/dev/null"
alias -g DN="/dev/null"
alias -g Il="| less"
alias -g Ill="2>&1 | less"
alias -g G="| grep -i"
#alias -g S="| sort"
alias -g C="| wc -l"
# }

# { lists
alias dir-stats='echo "\e[1;32m --[\e[1;34m Dirs:\e[1;36m `ls -Al | egrep \"^drw\" | wc -l` \e[1;32m|\e[1;35m Files: \e[1;31m`ls -al | egrep -v \"^drw\" | grep -v total | wc -l` \e[1;32m]--"'

alias ls="ls --color=auto -Fh"
alias sl=ls
alias l="ls -lA"               # show verbose list of files/dirs
alias L="ls -l"                # show verbose list of files/dirs NOT HIDDEN
alias ll="ls -ld -- *(/)"      # show verbose list of dirs
alias lL="ls -ld -- ^.*(/)"    # show verbose list of dirs NOT HIDDEN
alias lk="ls -l -- *(.)"       # show verbose list of files
alias lK="ls -l -- ^.*(.)"     # show verbose list of files NOT HIDDEN
alias lh="ls -lA -I \*"        # show verbose list of ONLY HIDDEN files and dirs
alias lsd="ls -d -- *(/)"      # show directories
alias lsD="ls -d -- ^.*(/)"    # show directories NOT HIDDEN
alias lsf="ls -- *(.)"         # show files
alias lsF="ls -- ^.*(.)"       # show filse NOT HIDDEN
alias lse="ls -d -- *(/^F)"    # only show empty directories

alias lsnew="=ls -rtlh -- *(.) | tail $@ 2&>/dev/null"  # only the newest files
alias lsold="=ls -rtl -- *(.) | head $@ 2&>/dev/null"   # display the oldest files
alias lssmall="=ls -Sl -- *(.) | tail $@ 2&>/dev/null"  # display the smallest files
alias lsbig="ls -lSh -- *(.) | grep -v total | head $@ 2&>/dev/null"    # display the biggest files
alias lsx="ls -l -- *(*) | head $@ 2&>/dev/null"        # only show executables
alias lssuid="ls -l -- *(s,S) | head $@ 2&>/dev/null"   # only show suid-files
# }

# { screen
alias screen="screen -U -l"
alias scr="screen -DR"
alias scd="screen -S"
# }

# { disable "spell-correction" for this commands:
alias mv="nocorrect mv -v"
alias cp="nocorrect cp -v"
alias rm="nocorrect rm -v"
alias man="nocorrect man"
alias mkdir="nocorrect mkdir"
alias mkcd="nocorrect mkcd"
# }

# { convert from UPPER to lower (or back)
alias UP2low='for i in *(.); mv $i ${i:l}'
alias low2UP='for i in *(.); mv $i ${i:u}'
# }

# { sudo X-trick
if ( which sudo >/dev/null 2>/dev/null ) ; then
   alias su='export XAUTHORITY=${HOME}/.Xauthority ; sudo -s'
   alias sudo='export XAUTHORITY=${HOME}/.Xauthority ; sudo'
fi
# }


# { check distribution for packet manager alias

  # { debian - APT
  if [[ -e '/etc/debian_version' ]]; then
  
    if [[ "$USER" != root ]]; then
      alias aptitude="sudo aptitude"
      alias apt-get="sudo apt-get"
      alias dpkg-reconfigure="sudo dpkg-reconfigure"
    fi
  
    alias A='aptitude'
    alias i='aptitude install'
    alias I='aptitude install --with-recommends'
    alias r='aptitude remove'
    alias R='aptitude purge'
    alias u='aptitude update'
    alias U='aptitude full-upgrade'
    alias ae='aptitude search'
    alias E='apt-cache search'
    alias AR='apt-get autoremove --purge'
    alias Al='dpkg -L'
    alias AL='dpkg -l'
    alias Re="dpkg-reconfigure"
    alias In="aptitude show -vV"
  # }
   
  # { archlinux - pacman
  elif [[ -e '/etc/arch-release' ]]; then
  
    if [[ "$USER" != root ]]; then
      alias pacman="sudo pacman"
    #  alias yaourt="sudo yaourt"
    fi
    alias e='pacman -Ss'
    alias E='pacman -Qs'
    alias i='pacman -S'
    alias u='pacman -Syu'
    alias r='pacman -R'
    alias R='pacman -Rsn'
    alias Al='pacman -Ql'
    alias AL='pacman -Q'
    alias Ao='pacman -Qo'
    alias Lo='pacman -Qdt' # list orphans
    alias Y='yaourt'
    alias Yi='yaourt -S'
    alias Ye='yaourt -Ss'
    alias Yu='yaourt -Syu --aur'
  # }
  
  # { gentoo - portage
  elif [[ -e '/etc/gentoo-release' ]]; then
  
    alias u='emerge --sync'
    alias U='emerge -Duav world'
    alias i='emerge -av'
    alias r='emerge -C'
    alias Al='equery f'
    alias AL='equery l'
  fi
  # }

# }


# { suffix aliases
alias -s txt=$EDITOR
alias -s dvi=xdvi
alias -s pdf=xpdf
alias -s ps=gv

alias -s {jpg,JPG,jpeg,JPEG,png,PNG,gif,GIF,xbm}="feh"

alias -s {mpg,mpeg,avi,ogm,wmv,m4v,mp4,mov,mkv}="mplayer"

alias -s {mp3,ogg,wav,flac}="mplayer"

alias -s html=${BROWSER:-lynx}
alias -s htm=${BROWSER:-lynx}

alias -s gz=show-archive
alias -s tar=show-archive
alias -s bz2=show-archive
alias -s zip=show-archive
# }

# { dir aliases
hash -d D=/media/HD-CRYPT/downloads/
hash -d HD=/media/HD-CRYPT
hash -d ZSHFUNC=/usr/share/zsh/$ZSH_VERSION/functions/
hash -d DOC=/home/kalos/doc
hash -d MUS=/home/kalos/Musica
hash -d GIT=/home/kalos/progetti/configs
hash -d I=/etc/init.d/
hash -d R=/etc/rc.d/
hash -d C=/etc/conf.d/
hash -d L=/usr/src/linux/
hash -d V=~/.vim/
hash -d VL=/var/log
hash -d Z=~/etc/zsh/
# }

# { kernel
#alias MS='make-kpkg --initrd --append-to-version=-nerdrug kernel_image kernel_headers'
#alias M='make-kpkg --initrd --append-to-version=-nerdrug kernel_image'
#alias I='/bin/bash -norc -noprofile -c "make install"'
#alias MI='/bin/bash -norc -noprofile -c "make modules_install"'
# }

# { configure
alias C='./configure'
alias CH='./configure --help | $PAGER'
# }

# { quick chmod
alias rw-='chmod 600'
alias rwx='chmod 700'
alias r--='chmod 644'
alias r-x='chmod 755'
# }

# { zmv -- see ``less ${^fpath}/zmv(N)'' for more details.
autoload zmv
alias zmv-help='less ${^fpath}/zmv(N)'
alias zcp='zmv -C'
alias zmv='noglob zmv -W'
alias zln='zmv -L'
# }

# { common apps

# commands starting with % for pasting from web
#alias %=' '

alias vi="vim"
alias em="emacsclient -t -a ''"

alias s='ssh'
alias Ps='ssh -MNf'

#ssh & scp without security checks
alias ssh-noverify='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
alias scp-noverify='scp -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'

alias iodrag='ionice -c3 nice -n19'

alias d2u='sed "s/.$//"'
alias u2d='sed "s/$/`echo r`/"'
#alias clear="tput reset"
alias clear="echo -ne '\033c'"
alias rmvoid="rm -i *(.L0)"
#alias rm_= "rm ./^*."
alias df="df -h"
alias h="history"
alias T="tail -f "
alias grep="grep --color=auto"
#alias startX='dbus-launch startx'
alias :q="echo 'doh!'"

alias xprop_name='xprop | grep --color=none "WM_WINDOW_ROLE\|WM_CLASS" | xmessage -file -'

# quick&dirty mirror
alias mirror="noglob wget --mirror --no-parent --recursive --timestamping --continue --recursive $1"
# }

# { no globbing
alias g='noglob git'
# }
