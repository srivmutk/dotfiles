# Global Config Syslink
	sudo ln -sf ~/.config/nvim/init.vim /etc/xdg/nvim
	sudo mkdir -p /etc/xdg/nvim/autoload
	sudo chmod 777 -R /etc/xdg/nvim

# Setup Vim Plug
	sh -c 'curl -fLo /etc/xdg/nvim/autoload/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Nodejs setup
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
	nvm install 14
	nvm use 14

# Optional Stuff
# -> Fixes an issue with npm
	# sudo chown -R 1000:1000 "~/.npm"

