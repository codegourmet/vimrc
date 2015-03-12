set nocompatible               " be iMproved

" **** TODO: LASTPOSITION EXCEPT FOR GIT

" { Vundle
	filetype off

	set rtp+=~/.vim/bundle/Vundle.vim/
	"call vundle#rc()
	call vundle#begin()

	" let Vundle manage Vundle
	Plugin 'gmarik/vundle'

	" use the original one, this one is just lazy zenburn change for me.
	"Bundle 'codegourmet/vim-airline'

	Plugin 'scrooloose/nerdtree'
	Plugin 'scrooloose/syntastic'
	Plugin 'tpope/vim-fugitive'
	Plugin 'tpope/vim-surround'
	Plugin 'tpope/vim-endwise'
	Plugin 'rking/ag.vim'
	Plugin 'jwhitley/vim-matchit'
	Plugin 'kien/ctrlp.vim'
	Plugin 'vim-ruby/vim-ruby'
	Plugin 'codegourmet/vim-pipe'
	Plugin 'Shutnik/jshint2.vim'
	Plugin 'majutsushi/tagbar'

	Plugin 'xolox/vim-misc'
	Plugin 'xolox/vim-session'

	Plugin 'hail2u/vim-css3-syntax'
	Plugin 'groenewege/vim-less'

	Plugin 'bufexplorer.zip'
	Plugin 'ShowMarks'
	Plugin 'snipMate'
	Plugin 'tComment'

	Plugin 'ecomba/vim-ruby-refactoring'
	Plugin 'AndrewRadev/switch.vim'

	Plugin 'farseer90718/vim-taskwarrior'

	Plugin 'terryma/vim-multiple-cursors'

	Plugin 'vim-scripts/renamer.vim'

	Plugin 'ngmy/vim-rubocop'

	" Plugin 'takac/vim-hardtime'

	call vundle#end()
	filetype plugin indent on
" }


" { Basic configuration
	let mapleader=','
	set nu " line numbers
	set virtualedit=block
	"set virtualedit=onemore " allow for cursor beyond last character
	set history=1000 " Store a ton of history (default is 20)
	set wildmenu                        " show list instead of just completing
	set wildmode=longest,list
	"set wildmode=list:longest,full      " command <Tab> completion, list matches,
	"									" then longest common part, then all.
	set whichwrap=b,s,h,l,<,>,[,]       " backspace and cursor keys wrap to
	set backspace=indent,eol,start      " backspace should behave like it's supposed to
	set scrolljump=5                    " lines to scroll when cursor leaves screen
	set scrolloff=3                     " minimum lines to keep above and below cursor
	set sidescrolloff=7
	set sidescroll=1
	set list
	set listchars=tab:\ \ ,trail:~,extends:>,precedes:<
	"set listchars+=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
	set mouse=a " automatically enable mouse usage

	let ttimeoutlen=50

	set textwidth=115

	set showmatch
	set cursorline
	set linespace=0
	set showbreak=ᶥ

	set splitright " split vertically

	set clipboard=unnamed " use X window clipboard as default


	let g:PI=3.14159265359 " for <C>-R= in insert mode
	let g:pi=3.14159265359 " for <C>-R= in insert mode

	set diffopt+=vertical
" }


" { Visual
	set t_Co=256 " tell the term has 256 colors
	set background=dark " Assume a dark background
	colorscheme zenburn
	set viewoptions=options,cursor,unix,slash
	set noshowmode
	set showcmd
" }


" Buffer Management {
	" TODO: see http://blog.codegourmet.de/2015/02/10/vim-modifiable-slash-readonly-buffer/
	au BufWritePost,BufLeave,WinLeave *.* mkview
	au BufWinEnter *.* silent loadview

	" Buffer explorer {
		nmap <leader>e :BufExplorer<CR>
	" }
" }


" { Encoding
	set fileformat=unix
	scriptencoding utf-8
	set enc=utf-8
	set fenc=utf-8
	set termencoding=utf-8
" }


" { Feedback
	set novisualbell  " No blinking .
	set noerrorbells  " No noise.
	set shortmess+=filmnrxoOtTI " abbrev. of messages (avoids 'hit enter')
	set timeoutlen=500 " Time to wait after ESC (default causes an annoying delay)
	let echoerrormessages=0
	let echowarningmessages=0
" }


" { line wrap
	set linebreak
	set wrap
	" Wrapped lines goes down/up to next row, rather than next line in file.
	"nnoremap j gj
	"nnoremap k gk

	if exists('+colorcolumn')
		"set colorcolumn=100
	endif
" }


" { Key remappings
    " Escape key replacement in insert mode
	inoremap jj <Esc>

    " { Math
	    " same as C-R= in insert mode
	    map <Leader>c :normal i=
	" }

	" { Tabs and Windows
		map <Leader>w <C-w>

		" nnoremap <C-h> <C-w>h
		" nnoremap <C-j> <C-w>j
		" nnoremap <C-k> <C-w>k
		" nnoremap <C-l> <C-w>l

		map <Leader>wm :vnew<CR>
		map <Leader>wq :bd!<CR>:redraw!<CR>

		map <Leader>cn :tabnew<CR>
		map <Leader>cl :tabnext<CR>
		map <Leader>ch :tabprevious<CR>
		map <Leader>cd :tabclose<CR>
	" }

	" { FileType
		:nnoremap <Leader>fr :set filetype=ruby<CR>
		:nnoremap <Leader>fj :set filetype=javascript<CR>
	" }
	
	" mark all
	nnoremap <C-g> ggVG
	
	" prevent cursor jumping when joining lines
	nnoremap J mzJ`z

	" { block/paragraph navigation
		map <C-j> })
		map <C-k> {(
	" }

	" { Source Code Navigation
		" jump into tag
		nnoremap ö <C-]>
		" jump back
		nnoremap Ö <C-O>
	" }

	" disable 'ex' mode
	nnoremap Q <nop>

	" 'stamping'
	nnoremap S viw"0P
" }


" { Source Code
	"set nospell " spell checking off
	syntax on " syntax highlighting
" }

" { Indentation
	set tabstop=2
	set shiftwidth=2
	set softtabstop=2
	set expandtab
" }


" { File handling
	set smartindent
	set autoindent
	filetype plugin indent on " Automatically detect file types.

	set backup " Enable creation of backup file.
	set backupdir=~/.vim/backup " Where backups will go.
	set directory=~/.vim/tmp " Where temporary files will go.

	com -nargs=0 Mkdir :!mkdir -p $(dirname "%")

	" { File Type dependent settings
		" http://vim.wikia.com/wiki/Indent_with_tabs,_align_with_spaces
		" NOTE: I know, ftplugin directory and stuff. but want to have single .vimrc!
		"
		autocmd FileType ruby setlocal ai sw=2 sts=2 ts=2 et
		autocmd FileType html,mustache,haml,ruby,rb,eruby,yaml setlocal ai sw=2 sts=2 ts=2 et
		autocmd FileType css,sass,less setlocal ai sw=2 sts=2 ts=2 et
		autocmd BufNewFile,BufReadPost *.json setlocal filetype=javascript.json
		autocmd FileType javascript,js,javascript.json setlocal ai sw=4 sts=4 ts=4 noet
		autocmd FileType vim setlocal ai sw=4 sts=4 ts=4 noet
		autocmd BufNewFile,BufReadPost *.mql setlocal filetype=mongoql
		autocmd BufNewFile,BufReadPost *.jst.hamljs setlocal filetype=haml

		" TODO why does FileType not work?
		autocmd BufNewFile,BufRead *.cpp,*.h setlocal noai sw=4 sts=4 ts=4 et
	" }
" }


" { General Aliases
	cmap w!! %!sudo tee >/dev/null %

    nnoremap <Space> ^
    nnoremap <silent> <Leader><Leader> :wa<CR>

	" wget read {
		com! -nargs=1 Rwget :exec "r !wget -qO- <args>"
	" }

	" read to current line (:R is to :r what P is to p) {
		com! -nargs=* R :exec "-1r <args>"
	" }

	" yank current file path into unnamed buffer
	nnoremap <silent> cp :let @*=expand("%:p")<CR>

" }

" { Search&Replace
	set gdefault " the /g flag on :s substitutions by default
	set hlsearch                        " highlight search terms
	set incsearch                       " find as you type search

	set ignorecase                      " non case-sensitive
	set smartcase                       " case sensitive when uc present

	hi Visual ctermfg=237 ctermbg=109
	hi IncSearch term=reverse cterm=reverse ctermfg=228 ctermbg=95
	hi Search term=reverse cterm=reverse ctermfg=228 ctermbg=95

	nnoremap Y y$

	" visual shifting (does not exit Visual mode)
	vnoremap < <gv
	vnoremap > >gv

    nnoremap n nzz

	" { visual search mappings
		function! s:VSetSearch()
			let temp = @@
			norm! gvy
			let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
			let @@ = temp
		endfunction

		noremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
		noremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

		nnoremap <silent> <Leader><Space> :set hls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>

        " NOTE SINGLE Esc BREAKS MY VIM! (somehow starts in insert mode instead of normal mode)
        nmap <silent> <Esc><Esc> :nohlsearch<CR>
	" }

    " s&r word under cursor
    nnoremap <Leader>/ /<C-r><C-w>

" }


" { Statusline
	if has('statusline')
		let g:bufferline_echo=0
		set laststatus=2

		set statusline=%<%f\                     " Filename
		"set statusline+=%w%h%m%r                 " Options
		"set statusline+=%{fugitive#statusline()} "  Git Hotness
		"set statusline+=\ [%{&ff}/%Y]            " filetype
		"set statusline+=\ [%{getcwd()}]          " current dir
		"set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
		"set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

		" fileformat
		set statusline+=\ %#warningmsg#
		set statusline+=%{&ff!='unix'?'['.&ff.']':''}
		set statusline+=%*

		" file encoding
 		set statusline+=\ %#warningmsg#
		set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
		set statusline+=%*

		set statusline+=%h      "help file flag
		"set statusline+=%y      "filetype
		set statusline+=%r      "read only flag
		set statusline+=%m      "modified flag

		set statusline+=\ %#warningmsg#
		set statusline+=%{SyntasticStatuslineFlag()}
		set statusline+=%*

		set statusline+=\ %#error#
		set statusline+=%{&paste?'[paste]':''}
		set statusline+=%*

		set statusline+=%=      "left/right separator
		set statusline+=%c,     "cursor column
		set statusline+=%l/%L   "cursor line/total lines
		set statusline+=\ %P    "percent through file

		"recalculate the trailing whitespace warning when idle, and after saving
		autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
		"recalculate the tab warning flag when idle and after writing
		autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
		"recalculate the long line warning when idle and after saving
		autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning
	endif
" }

" { Startup
	function NERDTreeAndTaskWarrior()
		TW
		NERDTreeToggle
		wincmd l " jump into TW buffer window
	endfunction

	" if argc() == 0
	" 	autocmd VimEnter * call NERDTreeAndTaskWarrior()
	" endif
" }

" { Tools
	" { Exuberant CTAGS
		map <Leader>R :!ctags --extra=+f --exclude=.git --exclude=log -R * `gem env gemdir`<CR><CR>
	" }


	" JSHint {
		nmap <C>l :JSHint<CR>
	" }
" }


" { Plugin configuration
	" { NERDTree
		map <Leader>t :NERDTreeToggle<CR>
		let NERDTreeKeepTreeInNewTab=1
	" }

	" { Syntastic
		map <Leader>r :Errors<CR>
		let g:syntastic_ruby_checkers = ['rubocop', 'mri']
		let g:syntastic_ruby_rubocop_exec = 'rubocop'
	" }

	" { Tagbar
		map <Leader>j :TagbarOpen fjc<CR>

		let g:tagbar_type_css = {
					\ 'ctagstype' : 'Css',
					\ 'kinds'     : [
					\ 'c:classes',
					\ 's:selectors',
					\ 'i:identities'
					\ ]
					\ }

		let g:tagbar_type_javascript = {
					\ 'ctagsbin' : '/path/to/jsctags'
					\ }

		let g:tagbar_type_ruby = {
					\ 'kinds' : [
					\ 'm:modules',
					\ 'c:classes',
					\ 'd:describes',
					\ 'C:contexts',
					\ 'f:methods',
					\ 'F:singleton methods'
					\ ]
					\ }

		let g:tagbar_type_markdown = {
					\ 'ctagstype' : 'markdown',
					\ 'kinds' : [
					\ 'h:Heading_L1',
					\ 'i:Heading_L2',
					\ 'k:Heading_L3'
					\ ]
					\ }
	" }

	" { Airline
		"let g:airline_powerline_fonts = 1
		"let g:airline#extensions#tabline#enabled = 1

		"let g:airline_mode_map = {
		
		"	\ '__' : '-',
		" 	\ 'n'  : 'N',
		" 	\ 'i'  : 'I',
		" 	\ 'R'  : 'R',
		" 	\ 'c'  : 'C',
		" 	\ 'v'  : 'V',
		" 	\ 'V'  : 'V',
		" 	\ 's'  : 'S',
		" 	\ 'S'  : 'S'
		" \ }
	" }

	" { Fugitive
		map <Leader>gs :Gstatus<CR>
		map <Leader>gc :Gcommit<CR>
		map <Leader>gd :Gdiff<CR>
	" }

	" { ShowMarks
		let showmarks_include = "abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXYZ"
		let g:showmarks_enable = 1
		" For marks a-z
		hi ShowMarksHLl term=reverse cterm=reverse ctermfg=227 ctermbg=95
		" For marks A-Z
		highlight ShowMarksHLu term=reverse cterm=reverse ctermfg=227 ctermbg=95
		" For all other marks
		highlight ShowMarksHLo term=reverse cterm=reverse ctermfg=227 ctermbg=95
		" For multiple marks on the same line.
		highlight ShowMarksHLm term=reverse cterm=reverse ctermfg=187 ctermbg=95

		map <silent> <unique> <leader>md :ShowMarksClearMark<cr>
	" }

	" { CtrlP
		" don't search in directory names (toggle with <c-d> during prompt)
		let g:ctrlp_by_filename=1
	" }

	" { tComment
		map <Leader>y :TComment<CR>
	" }
	
	" { vimpipe
		let g:vimpipe_silent = 1

		nnoremap <silent> <Leader>v :call VimPipe()<CR>

		"todo auto filetype preserve

		autocmd FileType sh let b:vimpipe_command="bash"
		autocmd FileType mongoql let b:vimpipe_command="mongo"
		autocmd FileType mongoql let b:vimpipe_filetype="javascript"
		autocmd FileType html let b:vimpipe_command="lynx -dump -stdin"
		autocmd FileType javascript.json let b:vimpipe_command="python -m json.tool"
		autocmd FileType javascript.json let b:vimpipe_filetype="javascript.json"

		autocmd FileType javascript.mongo let b:vimpipe_command="mongo energybox_development --eval \"x=`cat`;x.forEach instanceof Function ? x.forEach(printjson) : printjson(x)\""
		autocmd FileType javascript.mongo let b:vimpipe_filetype="javascript.json"

		autocmd FileType javascript let b:vimpipe_command="rhino -f ~/.rhino/includes/underscore-min.js <(cat)"
		autocmd FileType javascript vnoremap <silent> <Leader>v y<C-w>nVp:set filetype=javascript<CR>ggvG=

		autocmd FileType ruby let b:vimpipe_command="ruby"
		autocmd FileType ruby vnoremap <silent> <Leader>v y<C-w>nVp:set filetype=ruby<CR>ggvG=
	" }

	" { Vim-Session
		set ssop-=options    " do not store global and local values in a session
		set ssop-=folds      " do not store folds"

		let g:session_command_aliases = 1  " alias to Session<Action>, so we can use tab completion
		let g:session_autosave = "no"
		let g:session_autoload = "no"
	" }

	" { HardTime
		" default_on didnt work, doing manually:
	 	" autocmd VimEnter * :HardTimeOn
		" map <Leader>h :HardTimeToggle<CR>
		" let g:hardtime_showmsg = 1
		" let g:hardtime_ignore_buffer_patterns = ["NERD.*"]
		" let g:hardtime_ignore_quickfix = 1
		" let g:hardtime_allow_different_key = 1
		" let g:hardtime_maxcount = 2
	" }

	" { Switcher
		nnoremap - :Switch<cr>
	" }

	" {
		let g:vimrubocop_config = '~/.rubocop.yml'
	" }

	" { TaskWarrior
		nnoremap <silent> <Leader>a :tabnew<CR>:TW<CR>

		let g:task_gui_term = 0

		" default task report type
		let g:task_report_name     = 'next'
		" custom reports have to be listed explicitly to make them available
		let g:task_report_command  = []
		" whether the field under the cursor is highlighted
		let g:task_highlight_field = 1
		" can not make change to task data when set to 1
		let g:task_readonly        = 0
		" vim built-in term for task undo in gvim
		let g:task_gui_term        = 0
		" allows user to override task configurations. Seperated by space. Defaults to ''
		let g:task_rc_override     = 'rc.defaultwidth=999'
		" default fields to ask when adding a new task
		" TODO: find a way to set default priority
		let g:task_default_prompt  = ['project', 'description']
		" whether the info window is splited vertically
		let g:task_info_vsplit     = 0
		" info window size
		let g:task_info_size       = 30
		" info window position
		let g:task_info_position   = 'belowright'
		" directory to store log files defaults to taskwarrior data.location
		let g:task_log_directory   = '~/.task'
		" max number of historical entries
		let g:task_log_max         = '20'
		" forward arrow shown on statusline
		let g:task_left_arrow      = ' <<'
		" backward arrow ...
		let g:task_left_arrow      = '>> '
	" }

	" {
		let g:multi_cursor_exit_from_visual_mode = 0
		let g:multi_cursor_exit_from_insert_mode = 0
	" }

" }

" { Abbreviations
	iabbrev lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
	iabbrev htmlorem <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p><p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
" }
