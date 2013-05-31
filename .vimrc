let mapleader = ","
nmap <leader>v :tabedit $MYVIMRC<CR>

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


" set zencoding to ctrl-e
let g:user_zen_expandabbr_key = '<c-e>' 
let g:use_zen_complete_tag = 1

syntax on
set encoding=utf-8
set fileencoding=utf-8
set number
set ruler
filetype plugin indent on
set showcmd        " display incomplete commands
set incsearch        " do incremental searching
set autoread
set backupdir=~/.vim/vim-tmp,~/.tmp
set directory=~/.vim/vim-tmp,~/.tmp
set nowrap
set noerrorbells
set visualbell

" a tab is 2 spaces and converted into spaces, eek
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set copyindent

set runtimepath^=~/.vim/bundle/ctrlp.vim

" autocmd BufEnter * lcd %:p:h
imap jk <Esc>
imap <C-O> :NERDTreeToggle ~/<CR>

"init pathogen
call pathogen#infect()

"autocomplete
:set completeopt=longest,menuone
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" open omni completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" open user completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'


"configuring the MRU plugin
let MRU_Window_Height = 25 
let MRU_Max_Entries = 1000

"configuring NERDTree plugin
map <Leader>n :NERDTreeToggle<CR>

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup        " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

colorscheme torte

if has("gui_running")
    syntax on
    set hlsearch
    colorscheme ir_black
    set guifont:Menlo:h16
    set bs=2
    set ai
    set ruler
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

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

if has("autocmd")
  filetype indent on
endif

if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" from http://vimcasts.org/episodes/working-with-tabs/
" " For mac users (using the 'apple' key)
" map <D-S-]> gt
" map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

" for enabling the specky plugin
let g:speckyRunSpecCmd       = 'spec --color -f nested'
let g:speckyBannerKey        = "<C-S>b"
let g:speckyQuoteSwitcherKey = "<C-S>'"
let g:speckyRunRdocKey       = "<C-S>r"
let g:speckySpecSwitcherKey  = "<C-S>x"
let g:speckyRunSpecKey       = "<C-S>s"
let g:speckyWindowType       = 2
let g:speckySpecVersion      = 1
let g:speckyRunRdocCmd       = "spec -fs"

set makeprg=spec\ --color\ -f\ nested

" for the correct tab settings
" from http://vimcasts.org/episodes/tabs-and-spaces/
"
" blame others for their code
command! Blame :exec "!git blame -L ".line(".").",".line(".")." ".expand('%:p')

"  easier navigation between windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
