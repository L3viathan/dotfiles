" .vimrc
set autoindent
set background=light
set backspace=2
set backupdir=~/.vim/backup
set cul
set encoding=utf-8
set expandtab
set foldmethod=syntax
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set list listchars=tab:»·,trail:·
set magic
set nobackup
set nocompatible              " be iMproved, required
set noerrorbells
set noswapfile
set novisualbell
set number
set relativenumber
set ruler
set runtimepath^=~/.vim/bundle/ctrlp.vim
set scrolloff=2
set shiftwidth=4
set showcmd
set showmatch
set smarttab
set softtabstop=0
set t_vb=
set tabstop=4
set tm=500
set wildignore=*.o,*~,*.pyc
set wildmenu
set wildmode=list:longest,full

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'oblitum/rainbow'
Plugin 'mattn/webapi-vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'cirla/vim-giphy'
Plugin 'tmhedberg/SimpylFold'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive' " git stuff
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-commentary'
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=237
highlight LineNr       ctermbg=236 ctermfg=240
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=236
highlight IncSearch    ctermbg=3   ctermfg=1
highlight Search       ctermbg=1   ctermfg=3
highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=3   ctermfg=1
highlight SpellBad     ctermbg=0   ctermfg=1
" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" set leader key to comma
let g:airline_powerline_fonts = 1
let g:ctrlp_map = '<leader>f'
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height = 30
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_working_path_mode = 0
let g:mapleader = ","
let g:rainbow_active = 1

let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let mapleader = ","

" unmap F1 help
nmap <F1> <nop>
imap <F1> <nop>

if exists('+colorcolumn')
    set colorcolumn=80
endif

function SwitchBuffer()
    b#
endfunction

" save folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        silent :e " this will reload the file without trickeries
                  "(DOS line endings will be shown entirely )
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
          setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction

map <silent> <leader>h :Hexmode<CR>
map <silent> <leader>q :wq<CR>

colorscheme solarized


map <C-k> ~
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <leader>cd :cd %:p:h<cr>:pwd<cr> " switch CWD to dir of current buffer
map <silent> <leader><cr> :nohl<cr>
map <silent> <leader>P :set nopaste<cr>
map <silent> <leader>T :NERDTreeClose<cr>
map <silent> <leader>n :nohl<cr>
map <silent> <leader>n :set background=dark<CR>
map <silent> <leader>p :set paste<cr>
map <silent> <leader>t :NERDTree<cr>
map <silent> <leader>t :set background=light<CR>
map Q @q
map T ^
map Y y$ " Y yanks until end of line, not ==yy. More logical, but no-compat.

nmap <Tab> :call SwitchBuffer()<CR>
nmap <leader>w :w!<cr>

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nnoremap YQ ZQ
nnoremap YY ZZ

vnoremap <Space> zf
