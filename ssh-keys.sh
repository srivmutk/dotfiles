#!/bin/sh

eval "$(ssh-agent -s)" > /dev/null 2>&1

getSsh() {
        find ~/.ssh | grep -Ei id_rsa_  | grep -Eiv id_rsa.pub
}

ssh-add $(getSsh) > /dev/null 2>&1


