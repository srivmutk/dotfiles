set mouse=r
set number
set clipboard=unnamedplus
set paste

call plug#begin('/etc/.nvim/plugged')
  Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.7' }
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'preservim/nerdtree'
  Plug 'SidOfc/mkdx'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
   Plug 'tarekbecker/vim-yaml-formatter'
call plug#end()

colorscheme jellybeans

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

:let g:NERDTreeWinSize=25
:let NERDTreeShowHidden=1

map <C-u> :u<CR>
