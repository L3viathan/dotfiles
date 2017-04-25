" .vimrc
set autoindent
set background=light
set backspace=2
set nobackup
set nocompatible
set cul " highlight cursor line
set encoding=utf-8
set noerrorbells
set expandtab
set foldmethod=manual
set hlsearch
set incsearch
set nojs " single space after .!?
set laststatus=2
set lazyredraw
set list
set listchars=tab:▶\ ,trail:·,nbsp:⎵
set magic
set mouse=a
set mps+=«:»,“:”
set number
set ruler
set runtimepath^=~/.vim/bundle/ctrlp.vim
set scrolloff=2
set shiftwidth=4
set shortmess=filmnrxsToOI
set showcmd
set showmatch
set smarttab
set softtabstop=0
set noswapfile
set tabstop=4
set timeoutlen=1000 " for @sarnthil
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif
set ttimeoutlen=10
set tm=500
set visualbell
set t_vb=
set wildignore=*.o,*~,*.pyc
set wildmenu
set wildmode=list:longest,full

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'kana/vim-arpeggio'
Plugin 'kien/ctrlp.vim'
Plugin 'lervag/vimtex'
Plugin 'mattn/emmet-vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'oblitum/rainbow'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive' " git stuff
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'easymotion/vim-easymotion'
Plugin 'L3viathan/vim-cute-python'
Plugin 'matze/vim-move'
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

" highlight trailing spaces in annoying red
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : '𝐍',
  \ 'i'  : '𝐈',
  \ 'R'  : '𝐑',
  \ 'c'  : '𝐂',
  \ 'v'  : '𝐕',
  \ 'V'  : '𝐕𝐋',
  \ '' : '𝐕𝐁',
  \ 's'  : '𝐒',
  \ 'S'  : '𝐒𝐋',
  \ '' : '𝐒𝐁',
  \ }
let g:gitgutter_sign_added = '⊕'
let g:gitgutter_sign_removed = '⊖'
let g:gitgutter_sign_modified = '⊙'
let g:ctrlp_map = '<leader>f'
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height = 30
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_working_path_mode = 0
let g:vimtex_latexmk_enabled = 0
let g:mapleader = ","
let g:move_key_modifier = 'C'
let g:rainbow_active = 1

let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let hostname = substitute(system('hostname'), '\n', '', '')
let mapleader = ","

if exists('+colorcolumn')
    set colorcolumn=80
endif

function SwitchBuffer()
    b#
endfunction


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

let paste_mode = 0
func! Toggle_paste()
    if g:paste_mode == 0
        set paste
        set nonu norelativenumber
        GitGutterSignsDisable
        let g:paste_mode = 1
    else
        set nopaste
        set nu relativenumber
        GitGutterSignsEnable
        let g:paste_mode = 0
    endif
    return
endfunc

let conceal_mode = 1
func! Toggle_conceal()
    if g:conceal_mode == 0
        set conceallevel=1
        let g:conceal_mode = 1
    else
        set conceallevel=0
        let g:conceal_mode = 0
    endif
    return
endfunc

let mouse_mode = 1
func! Toggle_mouse()
    if g:mouse_mode == 0
        set mouse=a
        let g:mouse_mode = 1
    else
        set mouse=h
        let g:mouse_mode = 0
    endif
    return
endfunc

autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd BufWinEnter *.* silent loadview
autocmd BufWinLeave * call clearmatches()
autocmd BufWinLeave *.* mkview

autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

autocmd filetype crontab setlocal nobackup nowritebackup

" autocmd CursorHoldI * stopinsert " automatically go to normal mode after 4s

" autocmd FileType python BracelessEnable +indent +fold +highlight

colorscheme solarized

map <C-c> ~
map <Down> <Nop>
map <silent> <Left> :bprevious<cr>
map <silent> <Right> :bnext<cr>
map <Up> <Nop>
map <leader>cd :cd %:p:h<cr>:pwd<cr>
map <silent> <leader>T :NERDTreeClose<cr>
map <silent> <leader>m :call Toggle_mouse()<cr>
map <silent> <leader>M :MinimapToggle<cr>
map <silent> <leader>p :call Toggle_paste()<cr>
map <silent> <leader>c :call Toggle_conceal()<cr>
map Q @q
map T ^
map Y y$
nmap <Tab> :call SwitchBuffer()<CR>
nmap <F1> <nop>
cmap w!! w !sudo tee % > /dev/null

imap <F1> <nop>

nnoremap ' `
nnoremap + <C-A>
nnoremap - <C-X>
nnoremap <C-P> :!python3 %<cr>
nnoremap <C-j> 3<C-e>
nnoremap <C-k> 3<C-y>
nnoremap <silent> <Space> za
nnoremap <silent> <leader><cr> :nohl<cr>
nnoremap <silent> <leader>d :set background=dark<CR>
nnoremap <silent> <leader>h :Hexmode<CR>
nnoremap <silent> <leader>l :set background=light<CR>
nnoremap <silent> <leader>t :NERDTree<cr>
nnoremap YQ ZQ
nnoremap YY ZZ
nnoremap ö [
nnoremap ä ]
nnoremap Ö {
nnoremap Ä }
nnoremap ü :
nnoremap Ü ;

cnoremap <C-A> <Home>
cnoremap <C-E> <End>

vnoremap <Space> zf
vnoremap <leader>s :sort<cr>

call arpeggio#load()
Arpeggio inoremap jk <esc>
