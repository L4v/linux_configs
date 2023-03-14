" Vundle setup
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tikhomirov/vim-glsl'
Plugin 'NLKNguyen/papercolor-theme'
call vundle#end()

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dyng/ctrlsf.vim'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

filetype plugin indent on
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
"source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
" Keybindings
nnoremap <F2> :wa<cr>
inoremap <F2> <Esc>:wa<cr>gi
packloadall
silent! helptags ALL
" BACKSPACE
set nocompatible
set backspace=indent,eol,start
filetype plugin indent on
" gruvbox theme
"colorscheme gruvbox
colorscheme PaperColor
set background=dark
" Transparency to gruvbox theme
"hi Normal guibg=NONE ctermbg=NONE
" Indentation
filetype plugin indent on
set shiftwidth=2 smarttab
set expandtab
set tabstop=8 softtabstop=0
" Remove highlight after search when pressing ESC
nnoremap <esc> :noh \| :pclose <CR><esc>
" Disable ALE by default
let g:ale_enabled=0
" YouCompleteMe populate error list
let g:ycm_always_populate_location_list = 1
" YouCompleteMe auto closes scratch
let g:ycm_autoclose_preview_window_after_completion = 1
" NOTE(Jovan): kitty background issues fix https://sw.kovidgoyal.net/kitty/faq/#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
let &t_ut=''

" NOTE(Jovan): Keep clipboard when closing nvim
autocmd VimLeave * call system("xclip -selection clipboard -i", getreg('+'))

" NOTE(Jovan): Config file for coc.neovim
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1)
  : "\<C-h>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" NOTE(Jovan): CTRL SHIFT F
nmap <C-F>f <Plug>CtrlSFPrompt
nmap <C-F>n <Plug>CtrlSFCwordPath
nmap <C-F>p <Plug>CtrlSFPwordPath

" NOTE(Jovan): CTRL P
" Hide gitignore files
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" Show dotfiles
let g:ctrlp_show_hidden = 1
