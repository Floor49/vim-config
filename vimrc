"" Vundle
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
set rtp+=/usr/local/go/misc/vim
call vundle#rc()

filetype plugin indent on

"" Defaults
set encoding=utf-8
set autochdir
set nomodeline
set history=1000
set showmode
set scrolloff=3
set showcmd
set hidden
set wildmenu
set wildmode=list:longest,full
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*.bin
set visualbell
set ttyfast
set ruler
set laststatus=1

" Colors
syntax enable
"colorscheme solarized

"" Hilight trailing whitespace
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
" Set hilight group for whitespace
highlight BadWhitespace ctermbg=red guibg=red

" Mark leading tabs as bad
au BufRead,BufNewFile *.py,*.pyw,*.pp,*.go match BadWhitespace /^\t\+/
" Mark trailing whitespace as bad
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.pp,*.go match BadWhitespace /\s\+$/

"" Tab/indent settings
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set backspace=indent,eol,start

"" Search&Replace settings
nnoremap / /\v
vnoremap / /\v
set incsearch
set showmatch
nnoremap <leader><space> :nohlsearch<cr>

"" Show hidden chars
set listchars=tab:▸\ ,eol:¬

"" Syntax hilighting
syntax on
set t_Co=256

"" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=0
let g:syntastic_auto_loc_list=2
let g:syntastic_c_check_header = 0
let g:syntastic_c_no_include_search = 1
let g:syntastic_c_auto_refresh_includes = 0

" Select a text block based on indentation level
function! SelectIndent ()
  let temp_var=indent(line("."))
  while indent(line(".")-1) >= temp_var
    exe "normal k"
  endwhile
  exe "normal V"
  while indent(line(".")+1) >= temp_var
    exe "normal j"
  endwhile
endfun

" With a visual block selected, align =>'s
function! AlignFats()
  " Save the cursor position
  let save_cursor = getpos(".")
  " Select the current indent level
  call SelectIndent()
  " Align the fat commas
  exe "norm ."
  " Restore cursor position
  call setpos('.', save_cursor)
endfun

""yml support
" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

vmap . :Align =><CR>
noremap , :call AlignFats()<CR>
