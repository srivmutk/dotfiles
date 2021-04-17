# Global Config Syslink
	sudo ln -sf ~/.config/nvim/init.vim /etc/xdg/nvim


# Setup Vim Plug
       sh -c 'curl -fLo /etc/.nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


# Create VIM plug
	sudo mkdir /etc/.nvim/plugged
	sudo chown $USER:$USER -R /etc/.nvim
	sudo ln -sf /etc/.nvim/site/autoload/plug.vim ~/.local/share/nvim
