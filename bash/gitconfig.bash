
# depends on colors.bash

if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=true
    _info "sourced git prompt support"
else
	_error "no support for git in prompt"    
fi

if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
    _info "sourced git autocomplete support"
else
	_error "no support for git autocomplete"
fi

alias gs="git status"
alias gc="git commit -m"
alias ga="git add ."
alias assume_unchanged="git update-index --assume-unchanged"
