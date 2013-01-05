# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="kalos"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=7

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump git vagrant)

source $ZSH/oh-my-zsh.sh


### customization

# { paths
export PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin:/opt/sbin/"

# automatically remove duplicates from these arrays
typeset -gU path cdpath manpath fpath

# Clean the non-existing or duplicate dirs from my $PATH before export $PATH
path=($^path(N))

# local user bin
export PATH="$PATH:$HOME/.bin"
# }

# { rbenv support
if [[ -e $commands[rbenv] && $EUID != 0 ]]; then
  #export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
# }

# { stderr colored - https://github.com/sickill/stderred
if [[ -f $HOME/.local/lib/stderred.so ]]; then
  export LD_PRELOAD="$HOME/.local/lib/stderred.so"
fi
# }

# { umask
  # set the "umask" (see "man umask"):
  # ie read and write for the owner only.
    umask 002 # relaxed   -rwxrwxr-x
  # umask 022 # cautious  -rwxr-xr-x
  # umask 027 # uptight   -rwxr-x---
  # umask 077 # paranoid  -rwx------
  # umask 066 # bofh-like -rw-------

  # if root set umask to 022 to prevent new files being created group and world writable
  #if (( EUID == 0 )); then
  #    umask 022
  #fi
# }

# { startx
if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 && $(tty) = /dev/tty1 && $EUID != 0 ]] ; then
  exec startx
  # Could use xinit instead of startx
  #exec xinit -- /usr/bin/X -nolisten tcp vt7
fi
# }
