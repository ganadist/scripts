set nocompatible
filetype on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Include user's local vim bundles
" You can also override mapleader here
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim_bundles.local"))
  source ~/.vim_bundles.local
endif

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitive
"
" Git in vim, use ,gs for git status then - to stage then C to commit
" check :help Gstatus for more keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'tpope/vim-fugitive'

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
Bundle 'tpope/vim-sensible'

" filemanagement
Bundle 'scrooloose/nerdtree'
Bundle 'Xuyuanp/nerdtree-git-plugin'
Bundle 'jistr/vim-nerdtree-tabs'
map <Leader>n <plug>NERDTreeTabsToggle<CR>
Bundle 'kien/ctrlp.vim'

" git
Bundle 'airblade/vim-gitgutter'

" powerline
"Bundle 'powerline/powerline'
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
Bundle 'bling/vim-airline'
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
Bundle 'python.vim'
Bundle 'python_match.vim'
Bundle 'pythoncomplete'

" golang
Bundle 'fatih/vim-go'
Bundle 'vim-jp/vim-go-extra'

" completion
Bundle 'Shougo/neocomplcache'
"Bundle 'Rip-Rip/clang_complete'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdcommenter'
Bundle 'SearchComplete'
Bundle 'easymotion/vim-easymotion'

" delimitMate
" Bundle 'Raimondi/delimitMate'

" color
Bundle 'sjl/badwolf'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tomasr/molokai'
Bundle 'zaiste/Atom'
Bundle 'w0ng/vim-hybrid'

" tagbar
Bundle 'majutsushi/tagbar'

Bundle 'mileszs/ack.vim'

" Most Recently Used
Bundle 'mru.vim'

Bundle 'amix/open_file_under_cursor.vim'

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
autocmd FileType c,cc,cpp,h,hh setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79 fileformat=unix
autocmd FileType java setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79 fileformat=unix

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LAST SECTION
" Include user's local vim config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
set wrap
