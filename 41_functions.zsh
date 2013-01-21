# functions
#
# CopyLeft - Calogero Lo Leggio <kalos@nerdrug.org>



# vim(): open 'foo:12' as foo at line 12
# http://www.zsh.org/mla/users/2011/msg00333.html
#
# vim foo:
# vim foo
#
# vim foo:bar
# vim foo
#
# vim foo:123
# vim foo +123
#
# vim foo:123:
# vim foo +123
#
# vim foo:123:bar
# vim foo +123

v() {
  if test $# != 1 -o -r $1; then
    command vim "${@}"
  else
    local args
    args=(${(s.:.)1})
    [[ $#args -ge 2 && $args[2] == <-> ]] \
      && command vim $args[1] +$args[2] \
      || command vim $args[1]
  fi
}


edit-history () {
  emulate -LR zsh
  unsetopt append_history inc_append_history share_history

  # You may want these in this case even if not otherwise:
  # setopt hist_expire_dups_first hist_ignore_all_dups

  # The following gibberish creates a unique tempfile
  # and makes sure that we'll write the whole history
  local SAVEHIST=$HISTSIZE HISTFILE=${:-=(:)}$$

  # Make sure we write a new file and rename to the tempfile
  setopt no_hist_save_by_copy

  # Finally, the actual, useful work
  fc -W
  {
    if ${VISUAL:-${EDITOR:-vi}} $HISTFILE
    then
      # Truncate internal history to discard deleted lines
      HISTSIZE=0
      HISTSIZE=$SAVEHIST
      fc -R
    fi
  } always {
    rm -f $HISTFILE
  }
}

#function scrm() { screen -dr "$1" -X quit }

#function mkcd() { mkdir "$1" && cd "$1"; }

# Make ISO image. Query values interactively.
mkiso() {
  echo "Enter volume name:"
  read volume
  echo "Enter ISO Name (ie. tmp.iso):"
  read iso
  echo "Enter input directory or file:"
  read files
  echo "Building '$HOME/$iso'"
  mkisofs -o ~/$iso -A $volume -allow-multidot -J -R -iso-level 3 -V $volume -R $files
}

function calc() { echo "$*" | bc; }

function hex2dec { awk 'BEGIN { printf "%d\n",0x$1}'; }
function dec2hex { awk 'BEGIN { printf "%x\n",$1}'; }

function dsync () { rsync -lprt --progress --stats --delete "$1/" "$2/" }

function dict () {
    dictionary="english"
    [[ "$2" != "" ]] && dictionary=$2
    echo "DEFINE $dictionary $1\nQUIT" | netcat dict.org 2628
}   

# viewing man pages
#function man {
#    /usr/bin/man $* | col -bp | iconv -c | view -c 'set ft=man nomod nolist' -
#}

function mans {
    man $1 | grep -iC2 --color=always $2 | less
}
compdef $_comps[man] mans

# Search in the $HISTFILE and select result to execute
#function selhist()
#{
#  emulate -L zsh
#  local TAB=$'\t';
#  (( $# < 1 )) && {
#    echo "Usage: $0 command"
#    return 1
#  };
#  cmd=(${(f)"$(grep -w $1 $HISTFILE | sort | uniq | pr -tn)"})
#  print -l $cmd | less -F
#  echo -n "enter number of desired command [1 - $(( ${#cmd[@]} - 1 ))]: "
#  local answer
#  read answer
#  print -z "${cmd[$answer]#*$TAB}"
#}

# rfc2396 url encoding (by Bart Schaefer)
function urlencode() {
        setopt localoptions extendedglob
        input=( ${(s::)1} )
        print ${(j::)input/(#b)([^A-Za-z0-9_.--version\'\(\)-])/%$(([##16]#match))}
}

# MLDONKEY: Gives only the files that are currently downloaded
function mldl() { (echo vd; echo q) | nc localhost 4000 | sed "/Paused/d" | sed "/- *$/d" }

# Convert IPv6 to IPv4
function 6to4() {
        ipv4=`dig $1|grep -v '^;'|sed -e '/^$/d'|cut -f 6`
        echo; echo "ipv4 addr ==  $ipv4"
        printf "2002:%02x%02x:%02x%02x::1" `echo $ipv4 | tr "." " "`;echo
}


function S(){
  ssh -t "$1" 'tmux attach || tmux new || screen -DR'
}
compdef S=ssh

function any() {
        if [[ -z "$1" ]] ; then
                echo "any - grep for process(es) by keyword" >&2
                echo "Usage: any <keyword>" >&2 ; return 1
        else
                local STRING=$1
                local LENGTH=$(expr length $STRING)
                local FIRSCHAR=$(echo $(expr substr $STRING 1 1))
                local REST=$(echo $(expr substr $STRING 2 $LENGTH))
                ps xauwww| grep "[$FIRSCHAR]$REST"
        fi
}

# MISC: Making the right decisions is hard :>
function helpme()
{
        print "Please wait.. i'll think about.."
        for i in 1 2 3; do echo -ne "."; sleep 0.3; done
        if [ $RANDOM -gt $RANDOM ]
        then
                print "Yes\!"
        else
                print "No\!"
        fi
}

# SEARCH: find all suid files in $PATH #2
function findsuid()
{
        sudo find / -type f \( -perm -4000 -o -perm -2000 \) -ls > ~/.suid/suidfiles.`date "+%Y-%m-%d"`.out 2>&1
        sudo find / -type d \( -perm -4000 -o -perm -2000 \) -ls > ~/.suid/suiddirs.`date "+%Y-%m-%d"`.out 2>&1
#        sudo find / -type f \( -perm -2 -o -perm -20 \) -ls > ~/.suid/writefiles.`date "+%Y-%m-%d"`.out 2>&1
#        sudo find / -type d \( -perm -2 -o -perm -20 \) -ls > ~/.suid/writedirs.`date "+%Y-%m-%d"`.out 2>&1
}

# Recursively delete all .svn dirs
function rm_svn() {
  find "$@" -name .svn -print0 | xargs -0 rm -rf
}

# Use vim to convert plaintext to HTML
function 2html() { vim -u NONE -n -c ':syntax on' -c ':so $VIMRUNTIME/syntax/2html.vim' -c ':wqa' $1 > /dev/null 2> /dev/null }

# Usage: show-archive <archive>
# Description: view archive without unpack
function show-archive() {
  if [[ -f $1 ]]
  then
  	case $1 in
  		*.tar.gz)      gunzip -c $1 | tar -tf - -- ;;
  		*.tar)         tar -tf $1 ;;
  		*.tgz)         tar -ztf $1 ;;
  		*.zip)         unzip -l $1 ;;
  		*.bz2)         bzless $1 ;;
  		*)             echo "'$1' Error. Please go away" ;;
  	esac
  else
  	echo "'$1' is not a valid archive"
  fi
}

# provide useful information on globbing
H-Glob() {
echo -e "
/      directories
.      plain files
@      symbolic links
=      sockets
p      named pipes (FIFOs)
*      executable plain files (0100)
%      device files (character or block special)
%b     block special files
%c     character special files
r      owner-readable files (0400)
w      owner-writable files (0200)
x      owner-executable files (0100)
A      group-readable files (0040)
I      group-writable files (0020)
E      group-executable files (0010)
R      world-readable files (0004)
W      world-writable files (0002)
X      world-executable files (0001)
s      setuid files (04000)
S      setgid files (02000)
t      files with the sticky bit (01000)
print *(m-1)          # List files modified today.
print *(a1)           # List files accessed one day ago.
print *(@)            # Print links.
print *(Lk+50)        # List files > 50 Kilobytes.
print *(Lk-50)        # List files < 50 Kilobytes.
print **/*.c          # Recursively list all c files.
print **/*.c~file.c   # List all c files, except file.c
print (foo|bar).*     # List files whos names start foo or bar.
print *~*.*           # 
chmod 644 *(.^x)      # make all non-executable files publically readable
print -l *(.c|.h)     # List all c and header files on their own lines. 
print **/*(g:users:)  # Recursively list files with the group 'users'
echo /proc/*/cwd(:h:t:s/self//) # Analogue of >ps ax | awk '{print $1}'<

noglob zmv -W ??\ * 0??\ *  # move 01 to 001, 02 to 002, etc
"
}
