#Set Colors
bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

magenta=$(tput setaf 206)
red=$(tput setaf 197)
green=$(tput setaf 148)
yellow=$(tput setaf 227)
cyan=$(tput setaf 81)
blue=$(tput setaf 32)

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  hg root >/dev/null 2>/dev/null && echo 'Hg' && return
  echo '○'
}

TIMESTAMP='$(prompt_char) %{${yellow}%}%w • %{${bold}${yellow}%}%*%{$reset_color%}'

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{${bold}${yellow}%} [% NORMAL]%  %{${reset}%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $TIMESTAMP $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

PROMPT='%{${red}%}%n%{$reset_color%} at ${green}%m%{$reset_color%} in ${bold}${cyan}${PWD/#$HOME/~}%{$reset_color%}$(hg_prompt_info)$(git_super_status)
%{$reset_color%}$ %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" on "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=" | "
ZSH_THEME_GIT_PROMPT_BRANCH="${underline}${bold}${magenta}"
ZSH_THEME_GIT_PROMPT_STAGED="${green}{! %G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="${red}%{✖ %G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="${blue}%{✚ %G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{ ↓ %G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{ ↑ %G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{ … %G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="${bold}${green}%{✔ %G%}"
