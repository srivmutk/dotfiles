#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "$(ssh-agent -s)"  > /dev/null 2>&1

getSshKeys() {
        find /home/svm/.ssh | grep -Ei id_rsa | grep -Eiv id_rsa.pub
}

ssh-add $(getSshKeys) > /dev/null 2>&1

# alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
