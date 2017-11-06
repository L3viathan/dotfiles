" .vimrc
" Header stuff
set nocompatible
let mapleader = ","

" Options
set autoindent
set background=dark
set backspace=2
set colorcolumn=80
set cul " highlight cursor line
set encoding=utf-8
set expandtab
set foldmethod=manual
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:▶\ ,trail:·,nbsp:⍽
set magic
set mouse=a
set mps+=«:»,“:”
set noerrorbells
set number
set ruler
set scrolloff=2
set shiftwidth=4
set shortmess=filmnrxsToOI
set showcmd
set showmatch
set noshowmode
set smarttab
set softtabstop=0
set splitbelow
set splitright
set tabstop=4
set ttimeoutlen=10
set tm=500
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif
set t_vb=
set visualbell
set wildignore=*.o,*~,*.pyc
set wildmenu
set wildmode=list:longest,full

" Plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'drzel/vim-line-no-indicator'
Plugin 'easymotion/vim-easymotion'
Plugin 'ervandew/supertab'
Plugin 'junegunn/fzf'
Plugin 'lfv89/vim-interestingwords'
Plugin 'mattn/emmet-vim'
Plugin 'matze/vim-move'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mileszs/ack.vim'
Plugin 'oblitum/rainbow'
Plugin 'rhysd/committia.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'shinokada/dragvisuals.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive' " git stuff
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

" Plugin options
let g:ackprg = 'ag --vimgrep'
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
let g:ale_sign_error = ""
let g:ale_sign_warning = ""
let g:airline_section_z = '%{LineNoIndicator()} %l:%c'
let g:DVB_TrimWS = 1
let g:gitgutter_sign_added = '●'
let g:gitgutter_sign_removed = '●'
let g:gitgutter_sign_removed_first_line = '▲'
let g:gitgutter_sign_modified = '●'
let g:gitgutter_sign_modified_removed = '●'
let g:interestingWordsTermColors = ['154', '211']
let g:line_no_indicator_chars = [' ', '⠁', '⠉', '⠋', '⠛', '⠟', '⠿', '⡿', '⣿']
let g:move_key_modifier = 'C'
let g:rainbow_active = 1
let g:rainbow_ctermfgs = [1,2,3,4,5,6,9]

" Mappings
" command mode
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap w!! w !sudo tee % > /dev/null
" normal mode
nnoremap ' `
nnoremap + <C-A>
nnoremap - <C-X>
nnoremap <C-P> :!python3 %<cr>
nnoremap <C-c> ~
nnoremap <C-j> 3<C-e>
nnoremap <C-k> 3<C-y>
nnoremap <Down> <Nop>
nnoremap <F1> <nop>
nnoremap <Up> <Nop>
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
nnoremap <silent> <Left> :bprevious<cr>
nnoremap <silent> <Right> :bnext<cr>
nnoremap <silent> <Space> za
nnoremap <silent> <Tab> :call SwitchBuffer()<CR>
nnoremap <silent> <leader><cr> :nohl<cr>
nnoremap <silent> <leader>F :call AckAg()<cr>
nnoremap <silent> <leader>H :call ToggleHex()<CR>
nnoremap <silent> <leader>I :call UncolorAllWords()<cr>
nnoremap <silent> <leader>M :MinimapToggle<cr>
nnoremap <silent> <leader>T :NERDTreeClose<cr>
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>i :call InterestingWords('n')<cr>
nnoremap <silent> <leader>n :ALENextWrap<cr>
nnoremap <silent> <leader>N :ALEPreviousWrap<cr>
nnoremap <silent> <leader>m :call Toggle_mouse()<cr>
nnoremap <silent> <leader>p :call Toggle_paste()<cr>
nnoremap <silent> <leader>t :NERDTree<cr>
nnoremap <silent> <leader>d :bd<cr>
nnoremap Q @q
nnoremap Y y$
nnoremap YQ ZQ
nnoremap YY ZZ
nnoremap Ä }
nnoremap Ö {
nnoremap Ü ;
nnoremap ä ]
nnoremap ö [
nnoremap ü :
nmap cxgv `<cx`>
" visual mode
vnoremap <Space> zf
vnoremap <expr> <down> DVB_Drag('down')
vnoremap <expr> <left> DVB_Drag('left')
vnoremap <expr> <right> DVB_Drag('right')
vnoremap <expr> <up> DVB_Drag('up')
vnoremap <expr> D DVB_Duplicate()
vnoremap <leader>s :sort<cr>
vmap cx <esc>cxgv
" Functions
function SwitchBuffer()
    b#
endfunction

function AckAg()
    call inputsave()
    let search = input('> ')
    call inputrestore()
    execute 'Ack!' search
endfunction

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

func! Toggle_paste()
    if !exists("g:paste_mode") || g:paste_mode == 0
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

func! Toggle_mouse()
    if !exists("g:mouse_mode") || g:mouse_mode == 0
        set mouse=a
        let g:mouse_mode = 1
    else
        set mouse=h
        let g:mouse_mode = 0
    endif
    return
endfunc

" Autocmds
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd BufWinEnter *.* silent loadview
autocmd BufWinLeave * call clearmatches()
autocmd BufWinLeave *.* mkview
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd filetype crontab setlocal nobackup nowritebackup


" Highlights
highlight ExtraWhitespace ctermbg=1 guibg=red
match ExtraWhitespace /\s\+$/

" Misc
colorscheme solarized
