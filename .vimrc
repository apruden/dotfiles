" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off
call pathogen#infect()

if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" if has("vms")   " for the VMS OS
"  set nobackup		" do not keep a backup file, use versions instead
" else
"  set backup		" keep a backup file
" endif

set nobackup
set nowritebackup
set noswapfile

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
set t_Co=256

if has("gui_running")
  set hlsearch
  set guifont=DejaVu\ Sans\ Mono\ 12
" set guifont=Lucida_Console:h14:cANSI
  set guioptions-=T
  set guioptions-=r
  set lines=999 columns=999
  winpos 0 0
"  syntax on
"  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
  "autocmd BufWritePost *.py call Flake8()
else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" show with :set guifont?
" source $VIMRUNTIME/mswin.vim
" behave mswin

syntax on
colorscheme molokai

let g:user_zen_expandabbr_key = '<c-e>'
let g:use_zen_complete_tag = 1

set listchars=tab:>-,trail:-
set list

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
autocmd FileType html,htmldjango,xml :setlocal sw=2 ts=2 sts=2 noexpandtab
autocmd FileType erlang :setlocal sw=4 ts=4 sts=4 noexpandtab
autocmd FileType python :setlocal noexpandtab

set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set laststatus=2
