# command history configuration
# 
# CopyLeft - Calogero Lo Leggio <kalos@nerdrug.org>

  setopt append_history       # append to history, dont truncate it
  setopt bang_hist            # yeah ! expansion
  setopt extended_history     # regular history
  setopt hist_allow_clobber   # add | to redirections in history
unsetopt hist_beep            # don't beep on history expansion errors
  setopt hist_expire_dups_first
  setopt hist_find_no_dups    # don't show dups even if not contiguous
  setopt hist_ignore_all_dups # ignore all -- even non contiguous -- dups
  setopt hist_ignore_dups     # ignore contiguous dups
  setopt hist_ignore_space    # historify commands without spaces
  setopt hist_no_store        # remove 'history' access cmds from hist
  setopt hist_reduce_blanks   # remove superfluous blanks
  setopt hist_save_no_dups    # no dups on history saving
  setopt hist_verify          # some expansion gadget
  setopt inc_appendhistory    # dont' append incrementally
unsetopt share_history        # traditional bash-history

#[ -w ${HOME}/.zsh/history ] && HISTFILE=${HOME}/.zsh/history
#HISTFILE=${HOME}/.zsh/history
HISTSIZE=100000             # size of history
SAVEHIST=65536              # maximum of history events to be save
DIRSTACKSIZE=50
NULLCMD='cat'               # use cat for > null commands
