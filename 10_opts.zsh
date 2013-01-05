# zsh generic options
# 
# CopyLeft - Calogero Lo Leggio <kalos@nerdrug.org>

# { initialisation
  setopt all_export           # define = export
unsetopt global_export        # local vars are not globals one
  setopt global_rcs           # use global rcs
 #setopt rcs                  # source all /etc rcs
# } 

# { input/output
  setopt aliases              # expand aliases
  setopt clobber              # redirection can create files
  setopt correct              # try to correct command line
unsetopt correct_all          # don't coorect args
unsetopt flow_control         # ignore ^S/^Q
unsetopt ignore_eof           # don't ignore ^D
  setopt interactive_comments # allow comments in interactive shell
  setopt hash_cmds            # do not always search through path, hash cmds
  setopt hash_dirs            # hash directories holding commands too
unsetopt mail_warning         # auto-explained
  setopt path_dirs            # search in path even if cmd has '/' in it
  setopt print_eight_bit      # just to be sure
  setopt rc_quotes            # '' == ' in 'quoted exprs
unsetopt rm_star_silent       # ask user before rm foo/*
unsetopt rm_star_wait         # dont't idle 10 seconds
  setopt short_loops          # short loops
# } 

# { shell emulation
unsetopt bsd_echo             # dont want BSD echo compat
unsetopt csh_junkiehistory    # csh sucks
unsetopt csh_junkie_loops     # want do /list/; done
unsetopt csh_junkie_quotes    # csh quote rules sucks too
unsetopt csh_nullcmd          # want to keep my (READ)?NULLCMD settings
unsetopt csh_null_glob        # don't erase not matched globs silently
unsetopt ksh_arrays           # don't emulate ksh arrays
unsetopt ksh_autoload         # don't do some dark autoload on function call
  setopt ksh_option_print     # modify setopt output
unsetopt ksh_typeset          # use zsh typeset
unsetopt sh_file_expansion    # dont expand filnames first
unsetopt sh_nullcmd           # use my NULLCMD
  setopt sh_option_letters    # interprete single option letters a la ksh
unsetopt sh_word_split        # `s="a b"; a=($s)' => array of length 1, not 2
# } 

# { job control
  setopt auto_continue        # send SIGCONT to jobs disowned
  setopt auto_resume          # simgle word resume if possible
unsetopt bg_nice              # don't renice jobs in bg
  setopt check_jobs           # check jobs on exit
unsetopt hup                  # don't SIGHUP bg cmds on logout
  setopt long_list_jobs       # list jobs in long format
  setopt monitor              # job control
  setopt notify               # notify immediately, not on next prompt
# } 

# { changing directories
  setopt auto_cd              # do cd path if only 'path' is given as command
  setopt auto_pushd           # cd = pushd
unsetopt cdable_vars          # dont add ~ automagically
  setopt chase_dots           # foo/bar/.. isn't foo/ even if bar is a symlink
  setopt chase_links          # cd to a symlink is in fact cd to the true dir
  setopt pushd_ignore_dups    # ignore dups in pushd
  setopt pushd_minus          # exchange +/-
  setopt pushd_silent         # don't print stack after push/pop
  setopt pushd_to_home        # pushd == pushd $HOME
# } 

# { expansion and globbing
  setopt bad_pattern          # warn on bad file patterns
  setopt bare_glob_qual       # () is quaifier list
  setopt brace_ccl            # expand of {adasd}
  setopt case_glob            # case sensitive globbing
  setopt equals               # perform = file expansions
  setopt extended_glob        # #,~,^ expansion
  setopt glob                 # sure i want globbing
unsetopt glob_assign          # no globbing on foo=*, use foo=(*)
unsetopt glob_dots            # not require . in filename to be match explicitely
unsetopt glob_subst           # no recursive expansion
  setopt hist_subst_pattern   # substitutions in history using the :s and :&
unsetopt ignore_braces        # do not perform braces expansion
unsetopt ksh_glob             # ignore @ before ()
  setopt magic_equal_subst    # foo= is file expanded
unsetopt mark_dirs            # no adds / on dirs in filename completion
  setopt nomatch              # print error on non matched patterns
unsetopt null_glob            # don't delete not matched globs
  setopt numeric_glob_sort    # sort in numeric order rather than lexicographic
 #setopt rc_expand_param      # some expansion trick for arrays in params
unsetopt sh_glob              # allow globbing with [(|)<]
# } 

# { scripts and functions
  setopt c_bases              # understand 12#120 as 120 in base 12
unsetopt err_exit             # don't weant to see exit status even if nonzero
unsetopt err_return           # return from a function with non 0 ending cmds
  setopt exec                 # sure we want to exec commands
  setopt function_argzero     # $0 == name of script
  setopt multios              # multi redirection allowed
unsetopt octal_zeroes         # 010 = 9 sucks
unsetopt xtrace               # do not debug by default
# } 

# { prompting
unsetopt prompt_bang          # dont perform history expansion in prompt
unsetopt prompt_cr            # don'tprint <cr> before prompt ---> see precmd !
  setopt prompt_percent       # expand % escapes in prompt
  setopt prompt_subst         # subts in prompt
  setopt transient_rprompt    # better for cut/paste
# } 

# { misc
MAILCHECK=10
LISTMAX=200
watch=(notme)               # watch login/logout
WATCHFMT="%B->%b %n has just %a %(l:tty%l:%U-Ghost-%u)%(m: from %m:)"
LOGCHECK=20                 # interval in seconds between checks for login/logout
REPORTTIME=60               # report time if execution exceeds amount of seconds
TIMEFMT="Real: %E User: %U System: %S Percent: %P Cmd: %J"
# If this parameter is nonzero, the shell will receive an ALRM signal if a
# command is not entered within the specified number of seconds after issuing a
# prompt. If there is a trap on SIGALRM, it will be executed and a new alarm is
# scheduled using the value of the TMOUT parameter after executing the trap.
#TMOUT=1800
# }
