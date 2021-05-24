" ====> SYSNOMID's init.vim

" --------------------------------------------------------------------- 
" ===> General Setup

	" mouse support
	set mouse=a

	" numbers on left side of editing window
	set number

	" yank to system keyboard
	set clipboard=unnamedplus

	" fixes vim-closetag
	set nopaste

	set backspace=indent,eol,start
	set hidden
	filetype plugin indent on
	syntax on

	set encoding=utf-8

	" some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup

	" give more space for displaying messages.
	set cmdheight=2

	" having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
	" delays and poor user experience.
	set updatetime=300

	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c

" --------------------------------------------------------------------- 



" --------------------------------------------------------------------- 
" ===> vim-plug config

	call plug#begin('/etc/xdg/nvim/autoload/nvim/site/autoload')
		
		" colorscheme
		Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.7' }
		
		" git
		Plug 'tpope/vim-fugitive'
		
		" statusbar
		Plug 'vim-airline/vim-airline'
		
		" filetree
		Plug 'preservim/nerdtree'
		
		" icons on filetree
		Plug 'ryanoasis/vim-devicons'

		" md preview & yaml formatting
		Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
		Plug 'tarekbecker/vim-yaml-formatter'
		
		" autocompletion and error messages 
		Plug 'neoclide/coc.nvim', {'branch': 'release'}
	
		" typscript syntax highlighting
		Plug 'HerringtonDarkholme/yats.vim' 

		" gql syntax highlighting
		Plug 'jparise/vim-graphql'

		" auto close html tags
		Plug 'alvan/vim-closetag'

		" css color highlighting
		Plug 'tpope/vim-commentary'

		" notes
		Plug 'vimwiki/vimwiki'
		Plug 'junegunn/goyo.vim'

		" comment out lines
		Plug 'tpope/vim-commentary'

		" surround
		Plug 'tpope/vim-surround'
	call plug#end()

" --------------------------------------------------------------------- 



" --------------------------------------------------------------------- 
" ===> Main Setup

	" -> colorscheme
	colorscheme jellybeans

	" -> tabs
	autocmd Filetype css setlocal tabstop=2

	" -> prettier config
	command! -nargs=0 Prettier :CocCommand prettier.formatFile
	autocmd! BufWritePre Prettier

	" -> functions
		" -> Integrated Terminal Setup
		function Term()
			set splitbelow
			split
			terminal
			resize 5
			set signcolumn=no
			tnoremap <Esc> <C-\><C-n>
		endfunction

		" -> NERDTree File Tree Setup
		function NerdTree()
			NERDTree
			set signcolumn=no
		endfunction

	" -> maps
	map <C-u> :u<CR>
	map <C-t> :call Term()<CR>
	map <C-q> :qa! <CR>
	map <C-m> :MarkdownPreview <CR>
	tnoremap gc :Git

	" -> spellcheck
	autocmd BufRead,BufNewFile *.md setlocal spell
	
	" -> jsonc 
	autocmd FileType json syntax match Comment +\/\/.\+$+

" --------------------------------------------------------------------- 



" --------------------------------------------------------------------- 
" ===> coc.nvim Setup

	" coc language extensions
	let g:coc_global_extensions = [
		\'coc-markdownlint',
		\'coc-highlight',
		\'coc-vetur',
		\'coc-go',
		\'coc-pyright',
		\'coc-json',	 
		\'coc-tsserver', 
		\'coc-sh', 
		\'coc-git',
		\'coc-prisma', 
		\'coc-pairs',
		\'coc-prettier',
		\'coc-go',
		\'coc-clangd',
		\'coc-elixir',
		\'coc-css',
		\'coc-tailwindcss',
		\'coc-html',
		\'coc-rls'
	\]

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	if has("nvim-0.5.0") || has("patch-8.1.1564")
	  " Recently vim can merge signcolumn and number column into one
	  set signcolumn=number
	else
	  set signcolumn=yes
	endif

	" Use tab for trigger completion with characters ahead and navigate.
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config.
	inoremap <silent><expr> <TAB>
	      \ pumvisible() ? "\<C-n>" :
	      \ <SID>check_back_space() ? "\<TAB>" :
	      \ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <c-space> to trigger completion.
	if has('nvim')
	  inoremap <silent><expr> <c-space> coc#refresh()
	else
	  inoremap <silent><expr> <c-@> coc#refresh()
	endif

	" Make <CR> auto-select the first completion item and notify coc.nvim to
	" format on enter, <cr> could be remapped by other vim plugin
	inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
				      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
	  if (index(['vim','help'], &filetype) >= 0)
	    execute 'h '.expand('<cword>')
	  elseif (coc#rpc#ready())
	    call CocActionAsync('doHover')
	  else
	    execute '!' . &keywordprg . " " . expand('<cword>')
	  endif
	endfunction

	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Symbol renaming.
	nmap <leader>rn <Plug>(coc-rename)

	" Formatting selected code.
	xmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)

	augroup mygroup
	  autocmd!
	  " Setup formatexpr specified filetype(s).
	  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	  " Update signature help on jump placeholder.
	  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Applying codeAction to the selected region.
	" Example: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap keys for applying codeAction to the current buffer.
	nmap <leader>ac  <Plug>(coc-codeaction)
	" Apply AutoFix to problem on the current line.
	nmap <leader>qf  <Plug>(coc-fix-current)

	" Map function and class text objects
	" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
	xmap if <Plug>(coc-funcobj-i)
	omap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap af <Plug>(coc-funcobj-a)
	xmap ic <Plug>(coc-classobj-i)
	omap ic <Plug>(coc-classobj-i)
	xmap ac <Plug>(coc-classobj-a)
	omap ac <Plug>(coc-classobj-a)

	" Remap <C-f> and <C-b> for scroll float windows/popups.
	if has('nvim-0.4.0') || has('patch-8.2.0750')
	  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	 nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	endif

	" Use CTRL-S for selections ranges.
	" Requires 'textDocument/selectionRange' support of language server.
	nmap <silent> <C-l> <Plug>(coc-range-select)
	xmap <silent> <C-l> <Plug>(coc-range-select)

	" Add `:Format` command to format current buffer.
	command! -nargs=0 Format :call CocAction('format')

	" Add `:Fold` command to fold current buffer.
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	" Add `:OR` command for organize imports of the current buffer.
	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

	" Add (Neo)Vim's native statusline support.
	" NOTE: Please see `:h coc-status` for integrations with external plugins that
	" provide custom statusline: lightline.vim, vim-airline.
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

	" Mappings for CoCList
	" Show all diagnostics.
	nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
	" Manage extensions.
	nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
	" Show commands.
	nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document.
	nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols.
	nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
	" Resume latest coc list.
	nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" --------------------------------------------------------------------- 



" --------------------------------------------------------------------- 
" ===> NERDTree and integrated terminal setup

	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
	" -> Run NERDTree and Integrated Terminal, if you are in a directory 
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | call NerdTree() | wincmd p | ene | exe 'cd '.argv()[0] | endif
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | call Term() | wincmd p | ene | exe 'cd '.argv()[0] | endif
	
	"
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	
	" -> NERDTree Window Size
	:let NERDTreeShowHidden=1
	let g:NERDTreeWinSize=25

	" -> Autorefresh NERDTree
	autocmd BufEnter NERD_tree_* | execute 'normal R'

" ---------------------------------------------------------------------



" --------------------------------------------------------------------- 
" ===> HTML Tag Autocompletion
"
	" filenames like *.xml, *.html, *.xhtml, ...
	" These are the file extensions where this plugin is enabled.
	let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.js,*.tsx'

	" filenames like *.xml, *.xhtml, ...
	" This will make the list of non-closing tags self-closing in the specified files.
	let g:closetag_xhtml_filenames = '*.xml,*.xhtml,*.jsx,*.js,*.tsx'

	" filetypes like xml, html, xhtml, ...
	" These are the file types where this plugin is enabled.
	let g:closetag_filetypes = 'html,xhtml,jsx,js,tsx'

	" filetypes like xml, xhtml, ...
	" This will make the list of non-closing tags self-closing in the specified files.
	let g:closetag_xhtml_filetypes = 'xml,xhtml,jsx,js,tsx'

	" integer value [0|1]
	" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
	let g:closetag_emptyTags_caseSensitive = 1

	" Disables auto-close if not in a "valid" region (based on filetype)
	let g:closetag_regions = {
			\ 'typescript.tsx': 'jsxRegion,tsxRegion',
			\ 'javascript.jsx': 'jsxRegion',
			\ }
	" Shortcut for closing tags, default is '>'
	let g:closetag_shortcut = '>'

	" Add > at current position without closing the current tag, default is ''
	let g:closetag_close_shortcut = '<leader>>'

" --------------------------------------------------------------------- 

