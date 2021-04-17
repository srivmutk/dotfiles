#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

export HISTFILE=/dev/null

eval "$(ssh-agent -s)"

getSsh() {
	find /home/svm/.ssh | grep -Ei _rsa | grep -Eiv _rsa.pub 
}

ssh-add $(getSsh) > /dev/null 2>&1 

source "$HOME/.cargo/env"

export EDITOR=nvim

