##################################################
# KEY ENVIRONMENT AND SHELL VARIABLES
##################################################

# Add version managers to PATH. Make sure these are the last PATH variable changes.
export PATH="$HOME/.rvm/bin:$PATH"

autoload -U compinit
compinit
setopt complete_in_word
setopt auto_list

setopt autocd
setopt EXTENDED_GLOB
setopt HIST_IGNORE_ALL_DUPS
setopt AUTO_NAME_DIRS

# Command completion
source ~/.zsh/npm_autocomplete.sh

#export EDITOR="/usr/bin/emacs"
export EDITOR="/Users/matthias/bin/code -n -w"
export PAGER="/usr/bin/less"

# configure prompt with git status (https://github.com/olivierverdier/zsh-git-prompt)
source ~/.dotfiles/zsh/git-prompt/zshrc.sh
ZSH_THEME_GIT_PROMPT_NOCACHE=1
PROMPT=$'%{\e[36m%}[%{\e[1;3m%}%!%{\e[0;36m%} %D{%I:%M} %4~/$(git_super_status)%{\e[36m%}%{\e[0;36m%}]%{\e[0m%} '

HISTSIZE=200

# Make path elements act as word separators as in tcsh
WORDCHARS='*_-~;!#$%^()[]{}<>'

# ssh-agent
# eval "$(ssh-agent -s)"
# ssh-add -K ~/.ssh/...


##################################################
# TOOL INITIALIZATION
##################################################

# Enable autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Allow Homebrew to authenticate with GitHub, avoiding rate limiting issues [token expires 2022-08-01]
export HOMEBREW_GITHUB_API_TOKEN=`cat ~/.secret_homebrew_git_access_token`


##################################################
# ALIASES
##################################################

# Simple command shortcuts
alias grep=egrep
alias ll='ls -lF'
alias md='macdown'
alias vs='code'
alias t='tail -50'
alias tt='tail -150'
alias ttt='tail -500'
alias tf='tail -f'

alias h='history 1 | grep'   # auto-grep history

# directory navigation (see also functions below)
alias dirs='dirs -v'
alias d1='pushd +1'
alias d2='pushd +2'
alias d3='pushd +3'
alias d4='pushd +4'
alias d5='pushd +5'

# Get the path to the frontmost Finder window, if applicable
alias fd='osascript -e '\''
  tell application "Finder"
    set loc to target of front window
    if class of loc is folder then
      POSIX path of (loc as alias)
    else
      "."
    end if
  end tell'\'''
alias gofd='cd `fd`'


##################################################
# FUNCTIONS
##################################################

# Navigate up n directory levels
u() {
    cd `perl -e "print +(q:../: x $1);"`
}

# Navigate directory stack with keyboard (MAY NEED TO BE REWRITTEN)
d() {
    dir_index=`dirs -v | pushd_select`;
    if [[ $dir_index != "" ]]; then eval "pushd +$dir_index > /dev/null"; fi
}

# curl -> less
curll() {
    curl $@ | $PAGER
}

# launch MacDown (supports creating file)
macdown() {
    "$(mdfind kMDItemCFBundleIdentifier=com.uranusjr.macdown | head -n1)/Contents/SharedSupport/bin/macdown" $@
}

##################################################
# CLIENT-SPECIFIC EXTENSIONS
##################################################

[ -f ~/.zshenv.clients ] && source ~/.zshenv.clients
