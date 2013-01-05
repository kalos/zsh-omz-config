# kalos theme ispired by fishy theme

local pr_user_color='magenta'; [[ $UID -eq 0 ]] && local pr_user_color='red'
local pr_at_color='white'
local pr_host_color='magenta'; [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]] && local pr_host_color='green'
local pr_path_color='blue'

local pr_user="%{$fg[$pr_user_color]%}%n%{$reset_color%}"
local pr_at="%{$fg[$pr_at_color]%}@%{$reset_color%}"
local pr_host="%{$fg[$pr_host_color]%}%m%{$reset_color%}"
local pr_path="%{$fg_bold[$pr_path_color]%}%~%{$reset_color%}"
local pr_git_branch='$(git_prompt_status)%{$reset_color%}$(git_prompt_info)%{$reset_color%}'


PROMPT="${pr_user}${pr_at}${pr_host} ${pr_path} ${pr_git_branch}
%(!.#.») "
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

#ZSH_THEME_GIT_PROMPT_PREFIX=" "
#ZSH_THEME_GIT_PROMPT_SUFFIX=""
#ZSH_THEME_GIT_PROMPT_DIRTY=""
#ZSH_THEME_GIT_PROMPT_CLEAN=""

#ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
#ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}!"
#ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
#ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}>"
#ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#"
#ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"
