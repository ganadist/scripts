"if $LANG[0] == 'k' && $LANG[1] == 'o'
" set fileencoding=korea
"endif
"set tenc=utf8
"set enc=korea
"set notitle
"set noicon
set fileencodings=ucs-bom,utf-8,default,cp949,latin-1
set ffs=unix,dos
set background=dark

set nocompatible	" Use Vim defaults (much better!)
"set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" for filename completion 
set wildmode=list,full
set wildignore=*.o,*.obj,*.so*,*.a,*.class,*.jpg,*.jpeg,*.png,*.gif,*.bmp,*.ico
set mm=1024000

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set syn=whitespac
  set hlsearch
endif

if has("autocmd")
 augroup scheme
  au!
  au BufNewFile,BufReadPost *.defs set cindent ts=2 sw=2 shiftwidth=2 syntax=scheme
 augroup END
 
 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd FileType *      set formatoptions=tcql nocindent comments&
  autocmd FileType c,cpp,cc,C,override  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,:// ts=4 sw=4 softtabstop=4 expandtab
  "au BufNewFile,BufReadPost *.override set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,:// ts=8 sw=4 softtabstop=4 "expandtab
  "autocmd BufReadPre,FileReadPre	*.c !indent -kr -ts8 -i4 -psl <afile> 
  "autocmd BufWritePost,FileWritePost	*.c !indent -kr -ts8 -i4 -psl <afile> 
  autocmd FileType po,pot	source ~/.vim/plugin/po.vim
  au BufNewFile,BufReadPost *.java     set cindent shiftwidth=4 expandtab
  au BufNewFile,BufReadPost *.php3     set cindent shiftwidth=4
  au BufNewFile,BufReadPost *.pl,*.pm  set cindent shiftwidth=4
  au BufEnter               *.pl,*.pm  let oldkp=&kp | set keywordprg=perldoc\ -f
  au BufLeave               *.pl,*.pm  let &keywordprg=oldkp
  au BufNewFile,BufReadPost *.tex      set autoindent

 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  "	  read:	set binary mode before reading the file
  "		uncompress text in buffer after reading
  "	 write:	compress file after writing
  "	append:	uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre	*.gz set bin
  autocmd BufReadPost,FileReadPost	*.gz let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost	*.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost	*.gz set nobin
  autocmd BufReadPost,FileReadPost	*.gz let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost	*.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost	*.gz !gzip <afile>:r

  autocmd FileAppendPre			*.gz !gunzip <afile>
  autocmd FileAppendPre			*.gz !mv <afile>:r <afile>
  autocmd FileAppendPost		*.gz !mv <afile> <afile>:r
  autocmd FileAppendPost		*.gz !gzip <afile>:r
 augroup END

augroup bzip2
  " Remove all bzip2 autocommands
  au!

  " Enable editing of bzipped files
  "       read: set binary mode before reading the file
  "             uncompress text in buffer after reading
  "      write: compress file after writing
  "     append: uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre        *.bz2 set bin
  autocmd BufReadPre,FileReadPre        *.bz2 let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost      *.bz2 |'[,']!bunzip2
  autocmd BufReadPost,FileReadPost      *.bz2 let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost      *.bz2 execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost    *.bz2 !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost    *.bz2 !bzip2 <afile>:r

  autocmd FileAppendPre                 *.bz2 !bunzip2 <afile>
  autocmd FileAppendPre                 *.bz2 !mv <afile>:r <afile>
  autocmd FileAppendPost                *.bz2 !mv <afile> <afile>:r
  autocmd FileAppendPost                *.bz2 !bzip2 -9 --repetitive-best <afile>:r
augroup END

augroup Python   
  au!
  "au FileType python source /usr/share/vim/vimfiles/plugin/python.vim
  au BufRead,BufNewFile *.py set ts=4 sw=4 softtabstop=4 expandtab
  "au BufRead,BufNewFile *.py set ts=8 sw=4 softtabstop=4 expandtab
  au BufRead,BufNewFile *.py set smarttab smartindent sta   
"  au BufRead,BufNewFile *.py map <F5> :w<CR> :!python %<CR>
"  au BufRead,BufNewFile *.pyx set ts=8 sw=4 softtabstop=4 expandtab
"  au BufRead,BufNewFile *.pyx set smarttab smartindent sta
"  au BufRead,BufNewFile *.pxi set ts=8 sw=4 softtabstop=4 expandtab
"  au BufRead,BufNewFile *.pxi set smarttab smartindent sta
augroup END

  "autocmd FileType python set complete+=k/home/ganadist/.vim/pydiction iskeyword+=.,(
endif " has ("autocmd")

if &term=="xterm"
"    set term=rxvt
     set t_Co=8
     set t_Sb=^[4%dm
     set t_Sf=^[3%dm
endif
set ts=4
map <F1> K
map <F2> :w!<CR>
map <F3> v]}zf
map <F4> zo
map <F5> :25vs ./<CR>^Ww
map <F6> ^Ww
map <F7> O
map <F8> [i
map <F9> gd
map <F10> ''
map <F11> ^]
map <F12> ^T
"map u :GundoToggle<CR>
set tags=~/ctags/gtkctag,~/ctags/xctag,./tags,./TAGS,tags,TAGS,$ANDROID_BUILD_TOP/tags
