" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! BuildYCM(info)
    info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status == 'installed' || a:info.force
        !./install.py
    endif
endfunction

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
call plug#end()


set nocompatible

" filetype off
" call pathogen#infect()

if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" if has("vms")   " for the VMS OS
"  set nobackup  " do not keep a backup file, use versions instead
" else
"  set backup  " keep a backup file
" endif

set nobackup
set nowritebackup
set noswapfile

set history=50  " keep 50 lines of command line history
set ruler  " show the cursor position all the time
set showcmd  " display incomplete commands
set incsearch  " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq
" map <leader>j :RopeGotoDefinition<CR>
" map <leader>r :RopeRename<CR>

" Rope AutoComplete
" let ropevim_vim_completion = 1
" let ropevim_extended_complete = 1
" let g:ropevim_autoimport_modules = ["os.*","traceback"]
" imap <c-space> <C-R>=RopeCodeAssistInsertMode()<CR>

set encoding=utf-8

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
  set guifont=DejaVu\ Sans\ Mono\ 14
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

  set autoindent  " always set autoindenting on

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
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

set listchars=tab:>-,trail:-
set list

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
autocmd FileType html,htmldjango,xml :setlocal sw=2 ts=2 sts=2
autocmd FileType erlang :setlocal sw=4 ts=4 sts=4
autocmd FileType python :setlocal sw=4 ts=4 sts=4
autocmd FileType go: setlocal sw=4 ts=4 sts=4
autocmd FileType javascript :setlocal sw=2 ts=2 sts=2

" set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set laststatus=2

let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''

if executable('java') && filereadable('/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.5.400.v20190515-0925.jar')
        au User lsp_setup call lsp#register_server({
                \ 'name': 'eclipse.jdt.ls',
                \ 'cmd': {server_info->[
                \     'java',
                \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                \     '-Dosgi.bundles.defaultStartLevel=4',
                \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
                \     '-Dlog.level=ALL',
                \     '-noverify',
                \     '-Dfile.encoding=UTF-8',
                \     '-Xmx1G',
                \     '-jar',
                \     expand('/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.5.400.v20190515-0925.jar'),
                \     '-configuration',
                \     expand('/usr/share/java/jdtls/config_linux'),
                \     '-data',
                \     getcwd()
                \ ]},
                \ 'whitelist': ['java'],
                \ })
endif

if executable('typescript-language-server')
        au User lsp_setup call lsp#register_server({
                \ 'name': 'typescript-language-server',
                \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
                \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
                \ 'whitelist': ['typescript', 'typescript.tsx'],
                \ })
endif

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

" for asyncomplete.vim log
let g:asyncomplete_log_file = expand('~/asyncomplete.log')

let g:ctrlp_working_path_mode = 0
