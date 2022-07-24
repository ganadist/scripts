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

Plug 'github/copilot.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitive
"
" Git in vim, use ,gs for git status then - to stage then C to commit
" check :help Gstatus for more keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-fugitive'
Plug 'lambdalisue/gina.vim'
Plug 'sharkdp/bat'
Plug 'ryanoasis/vim-devicons'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}

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
Plug 'editorconfig/editorconfig-vim'

" golang
Plug 'fatih/vim-go'
"Plug 'vim-jp/vim-go-extra'
Plug 'google/vim-ft-go'

" kotlin
Plug 'udalov/kotlin-vim'

" Bazel
Plug 'bazelbuild/vim-bazel'
Plug 'bazelbuild/vim-ft-bzl'

" completion
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'

Plug 'google/vim-maktaba'
" Strongly recommended: easy configuration of maktaba plugins.
Plug 'google/vim-glaive'

Plug 'google/vim-codefmt'
Plug 'google/vim-codereview'
Plug 'google/vim-coverage'
Plug 'google/vim-ft-vroom'
Plug 'google/vim-searchindex'
Plug 'google/vim-selector'
Plug 'google/vim-syncopate'

" delimitMate
" Bundle 'Raimondi/delimitMate'

" color
Plug 'google/vim-colorscheme-primary'

" tagbar
Plug 'majutsushi/tagbar'

Plug 'mileszs/ack.vim'

" Add plugins to &runtimepath
call plug#end()


" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
"if filereadable(expand("~/lib/google-java-format-1.3-all-deps.jar"))
"Glaive codefmt google_java_executable="java -jar /home/ganadist/lib/google-java-format-1.3-all-deps.jar"
"endif

" Optional: Enable coverage's default mappings on the <Leader>C prefix.
Glaive coverage plugin[mappings]
" Optional: Enable syncopate's default mappings on the <Leader>< prefix.
Glaive syncopate plugin[mappings]

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

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
"  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  "autocmd FileType java AutoFormatBuffer google-java-format
  "autocmd FileType python AutoFormatBuffer yapf
  "  autocmd FileType python AutoFormatBuffer autopep8
augroup END<Paste>

" makefile
autocmd FileType make setlocal noexpandtab
" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
autocmd FileType python setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79 fileformat=unix
" c, cpp
autocmd FileType c,cc,cpp,h,hh setlocal textwidth=79 fileformat=unix
autocmd FileType java setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79 fileformat=unix
autocmd FileType kotlin setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4 textwidth=99 fileformat=unix
autocmd FileType xml setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79 fileformat=unix
" gradle, kts
autocmd FileType gradle, kts setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4 textwidth=99 fileformat=unix

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LAST SECTION
" Include user's local vim config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
if filereadable(expand("~/.vim/vimrc.coc"))
  source ~/.vim/vimrc.coc
endif
if filereadable(expand("~/.vim/vimrc.airline"))
  source ~/.vim/vimrc.airline
endif
if filereadable(expand("~/.vim/vimrc.fugitive"))
  source ~/.vim/vimrc.fugitive
endif
if filereadable(expand("~/.vim/vimrc.fzf"))
  source ~/.vim/vimrc.f
endif

set wrap
set modelines=5

let g:copilot_filetypes = {
    \ '*': v:false,
    \ 'vim': v:true,
    \ 'gradle': v:true,
    \ 'groovy': v:true,
    \ 'kotlin': v:true,
    \ 'kts': v:true,
    \ 'java': v:true,
    \ 'python': v:true,
    \ 'sh': v:true,
    \ }
