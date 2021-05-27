# -> Syslink dotfiles/nvim to ~/.config/nvim
stow -S nvim

# -> Global Configuration Syslink
	ln -sf ~/.config/nvim/init.vim /etc/xdg/nvim
	mkdir -p /etc/xdg/nvim/site
	chmod 777 -R /etc/xdg/nvim

# -> Setup Vim Plug
	sh -c 'curl -fLo /etc/xdg/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# -> Nodejs setup
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
	nvm install 14
	nvm use 14

# -> Make a spell file
	mkdir nvim/.config/nvim/spell
	touch nvim/.config/nvim/en.us-UTF-8.add

# Optional Stuff
# -> Fixes an issue with npm
	# sudo chown -R 1000:1000 "~/.npm"

