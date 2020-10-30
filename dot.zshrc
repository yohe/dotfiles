#bindkey -v

autoload -U compinit
compinit
fpath=(~/.zsh $fpath)

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ls='ls -G'

setopt auto_pushd
setopt auto_cd

source ~/.zsh/.git-prompt.sh

# この行は現在のパスを表示する設定です。ブランチを表示して色をつける設定とは関係ありません
#RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

## GIT 
PROMPT='%D{%Y-%m-%d %H:%M:%S} %10F%n%f@%14F%m%f %~
$ '
setopt PROMPT_SUBST
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.zsh
