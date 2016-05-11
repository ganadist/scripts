set nocompatible
filetype on
filetype off

call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Include user's local vim bundles
" You can also override mapleader here
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"if filereadable(expand("~/.vim_bundles.local"))
"  source ~/.vim_bundles.local
"endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitive
"
" Git in vim, use ,gs for git status then - to stage then C to commit
" check :help Gstatus for more keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-fugitive'

map <leader>gs :Gstatus<cr>
map <leader>gc :Gcommit<cr>
map <leader>ga :Git add --all<cr>:Gcommit<cr>
map <leader>gb :Gblame<cr>

" Use j/k in status
function! BufReadIndex()
  setlocal cursorline
  setlocal nohlsearch

  nnoremap <buffer> <silent> j :call search('^#\t.*','W')<Bar>.<CR>
  nnoremap <buffer> <silent> k :call search('^#\t.*','Wbe')<Bar>.<CR>
endfunction
autocmd BufReadCmd  *.git/index exe BufReadIndex()
autocmd BufEnter    *.git/index silent normal gg0j

" Start in insert mode for commit
function! BufEnterCommit()
  normal gg0
  if getline('.') == ''
    start
  end
endfunction
autocmd BufEnter    *.git/COMMIT_EDITMSG  exe BufEnterCommit()

" Automatically remove fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sensible
"
" Defaults everyone can agree on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-sensible'

" filemanagement
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
map <Leader>n <plug>NERDTreeTabsToggle<CR>
Plug 'kien/ctrlp.vim'

" git
Plug 'airblade/vim-gitgutter'

" powerline
"Bundle 'powerline/powerline'
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
Plug 'bling/vim-airline'
let g:airline#extensions#tabline#enabled=1
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_powerline_fonts=0
let g:airline_inactive_collapse=1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" python
"Bundle 'klen/python-mode'
Plug 'python.vim'
Plug 'python_match.vim'
Plug 'pythoncomplete'

" golang
Plug 'fatih/vim-go'
Plug 'vim-jp/vim-go-extra'

" completion
Plug 'Shougo/neocomplcache'
"Bundle 'Rip-Rip/clang_complete'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'SearchComplete'
Plug 'easymotion/vim-easymotion'

" delimitMate
" Bundle 'Raimondi/delimitMate'

" color
Plug 'sjl/badwolf'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'zaiste/Atom'
Plug 'w0ng/vim-hybrid'

" tagbar
Plug 'majutsushi/tagbar'

Plug 'mileszs/ack.vim'

" Most Recently Used
Plug 'mru.vim'

Plug 'amix/open_file_under_cursor.vim'

" Add plugins to &runtimepath
call plug#end()

filetype plugin indent on

" Backups and swap
set nobackup
set nowritebackup
set noswapfile
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/backup

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Persistent undo
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile
set undodir=$HOME/.vim/undo

set undolevels=1000
set undoreload=10000


"colorscheme hybrid
syntax on

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'


" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" makefile
autocmd FileType make setlocal noexpandtab
" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
autocmd FileType python setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79 fileformat=unix
" c, cpp
autocmd FileType c,cc,cpp,h,hh setlocal textwidth=79 fileformat=unix
autocmd FileType java setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79 fileformat=unix

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LAST SECTION
" Include user's local vim config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
set wrap
