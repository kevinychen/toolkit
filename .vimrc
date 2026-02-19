" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

set showmatch
set hlsearch
set smartcase
set incsearch
set rnu
set expandtab
set shiftwidth=4
set autoindent
set lazyredraw
set re=0
set matchpairs+=<:>

" To add more plugins, add the line, open vim, and run :PluginInstall
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'petRUShka/vim-sage'
call vundle#end()

source ~/.vim/comments.vim

syntax on
filetype on
filetype plugin indent on

au BufReadPost,BufNewFile *.css colorscheme slate
au BufReadPost,BufNewFile *.js colorscheme slate2
au BufReadPost,BufNewFile *.py colorscheme molokaiyo
au BufReadPost,BufNewFile *.html colorscheme monokai
au BufReadPost,BufNewFile *.java colorscheme monokai
au BufReadPost,BufNewFile *.gradle set filetype=groovy

set rtp+=/usr/local/opt/fzf
set clipboard=unnamed,unnamedplus
set indentkeys-=<:><CR>
let groovy_regex_strings=1

" Block cursor
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
map m <Plug>(easymotion-s)
nnoremap -A ggVG
" -B is hex dump
nnoremap -B :%!xxd<CR>
" -c used for comments.vim
nnoremap -d o<Esc>k
nnoremap -e :e<CR>
nnoremap -f :vsp<CR>:FZF<CR>
nnoremap -H :browse oldfiles<CR>
nnoremap -J ggVG:!python3 -m json.tool<CR>
nnoremap -n :next<CR>
nnoremap -N :set nopaste<CR>
nnoremap -o :o
nnoremap -p :prev<CR>
nnoremap -P :set paste<CR>
nnoremap -q :q<CR>
nnoremap -Q :qall<CR>
nnoremap -R :set nornu<CR>
nnoremap -r :Re<CR>
nnoremap -s :sp
nnoremap -S :syntax sync fromstart<CR>
nnoremap -u O<Esc>j
nnoremap -U YpVr=
nnoremap -v :vsp
nnoremap -w :w<CR>
" -x used for comments.vim
nnoremap -` /````<CR>
nnoremap -2 :set shiftwidth=2<CR>
nnoremap -4 :set shiftwidth=4<CR>
nnoremap -8 :set shiftwidth=8<CR>
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

:command Gbl Git blame
