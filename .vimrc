" .vimrc

" OPTIONS
set nocompatible                " turn off Vi-compatibility
set autoindent                  " automatically indent if necessary
set backspace=2                 " backspace over lines
set backupdir=~/.vim/backup     " write backupfiles to central dir
set background=dark
" set cursorline                " highlight cursor line. Taken out: lag
set encoding=utf-8              " UTF-8 always, everywhere
set noerrorbells visualbell t_vb=  " shut up
set expandtab                   " no literal tab characters
set foldmethod=manual           " fold when I want to
set colorcolumn=80,81,82,83,84,85,86,87,88,89
set incsearch hlsearch          " search immediately and highlight
set nojoinspaces                " single space after .!?
set laststatus=2                " necessary for lightline
set lazyredraw                  " don't redraw screen during macros
set list                        " show whitespace with special chars:
set listchars=tab:▶\ ,trail:·,nbsp:⎵   " these.
set magic                       " default to magic mode in regex
set mouse=a                     " always enable mouse
set matchpairs+=«:»,“:”         " additional matching pairs for %
set number                      " show line numbers
set ruler                       " show line and col number of cursor
set scrolloff=2                 " always show 2 lines of extra context
set shiftwidth=4 tabstop=4 softtabstop=0  " indentation with 4 spaces
set shortmess=filmnrxsToOI      " shorter messages for some prompts
set showcmd                     " show command in last line
set showmatch                   " briefly jump to matching paren
set noshowmode                  " don't show mode (because lightline shows it)
set smarttab                    " tab and untab sw spaces
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif
set undofile undodir=~/.vim/undo  " write persistent undo file
set wildignore=*.o,*~,*.pyc     " ignore in wild menu
set wildmenu                    " enable wild menu
set wildmode=list:longest,full  " how to suggest in wild menu

" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'L3viathan/flattened'
Plug 'drzel/vim-line-no-indicator'
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', {'on': 'FZF', 'do': 'yes \| ./install' }
Plug 'lfv89/vim-interestingwords'
Plug 'matze/vim-move'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mileszs/ack.vim'
Plug 'oblitum/rainbow'
Plug 'rhysd/committia.vim'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'shinokada/dragvisuals.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive' " git stuff
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale', {'for': 'python'}
Plug 'L3viathan/black', {'for': 'python'}
Plug 'FooSoft/vim-argwrap'
Plug 'christoomey/vim-sort-motion'
Plug 'Olical/vim-enmasse'
Plug 'gioele/vim-autoswap'
call plug#end()
filetype plugin indent on    " required
syntax on


" ASSIGNMENTS (mostly for plugins)

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'right': [ [ 'charvaluehex', 'lineinfo', 'linenoindicator' ],
  \              [ 'fileformat', 'fileencoding', 'filetype'] ]
  \ },
  \ 'component': {
  \   'charvaluehex': '0x%B',
  \   'linenoindicator': '%{LineNoIndicator()}'
  \ },
  \ 'mode_map': {
  \   'n': '𝐍',
  \   'i': '𝐈',
  \   'R': '𝐑',
  \   'c': '𝐂',
  \   'v': '𝐕',
  \   'V': '𝐕𝐋',
  \   '\<C-v>': '𝐕𝐁',
  \   's': '𝐒',
  \   'S': '𝐒𝐋',
  \   '\<C-s>': '𝐒𝐁',
  \   't': '𝐓',
  \ },
  \ }

let g:ale_fixers = ['pylint']
let g:ale_set_balloons = 0  " fixes an issue that occurs when ttymouse=xterm2
let g:ackprg = 'rg --vimgrep'
let g:autoswap_detect_tmux = 1
let g:black_linelength = 80
let g:gitgutter_sign_added = '⊕'
let g:gitgutter_sign_removed = '⊖'
let g:gitgutter_sign_modified = '⊙'
let g:mapleader = " "
let g:move_key_modifier = 'C'
let g:rainbow_active = 1
let g:rainbow_ctermfgs = [1, 2, 3, 4, 5, 6, 7, 9]
let g:DVB_TrimWS = 1
let g:line_no_indicator_chars = [' ', '⠁', '⠉', '⠋', '⠛', '⠟', '⠿', '⡿', '⣿']

let hostname = substitute(system('hostname'), '\n', '', '')

command! -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function! ToggleHex()
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

function! AckAg()
    call inputsave()
    let search = input('> ')
    call inputrestore()
    execute 'Ack!' search
endfunction


function! SetTrailing()
    if &ft == 'json'
        let b:argwrap_tail_comma = 0
    else
        let b:argwrap_tail_comma = 1
    endif
endfun

function! RunTests()
    let number_of_panes = str2nr(system('tmux list-panes | wc -l'))
    if number_of_panes ==# 1
        call system('tmux split-window -h -c "#{pane_current_path}"')
        call system('tmux select-pane -t left')
        call system('tmux send-keys -t right "cd $(git rev-parse --show-toplevel)" C-m C-l')
    endif
    call system('tmux send-keys -t right "py.test test" C-m')
endfun


" AUTOCMDS
augroup vimrc
    autocmd!
    autocmd BufWinEnter *.* silent loadview
    autocmd BufWinLeave * call clearmatches()
    autocmd BufWinLeave *.* mkview
    autocmd filetype crontab setlocal nobackup nowritebackup
    autocmd BufRead * call SetTrailing()
    autocmd filetype qf nnoremap M :EnMasse<cr>
augroup END


" MAPPINGS

noremap <C-c> ~
noremap <Down> <Nop>
noremap <F1> <nop>
noremap <Up> <Nop>
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>
noremap <leader>p "+p
noremap <leader>P "+P
noremap <leader>y "+y
noremap <silent> <Left> :bprevious<cr>
noremap <silent> <Right> :bnext<cr>
noremap Q @q
noremap Y y$

cnoremap W!! w !sudo tee % > /dev/null
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

nmap S yss
nmap cxgv `<cx`>
nmap s ys
nnoremap <silent> K */\(def \\|class \)\@<=/<cr>
nnoremap ' `
nnoremap + <C-A>
nnoremap - <C-X>
nnoremap <C-P> :!python3 %<cr>
nnoremap <C-j> 3<C-e>
nnoremap <C-k> 3<C-y>
nnoremap <silent> <leader><cr> :nohl<cr>
nnoremap <silent> <leader>F :call AckAg()<cr>
nnoremap <silent> <leader>H :Hexmode<CR>
nnoremap <silent> <leader>N :ALEPreviousWrap<cr>
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>n :ALENextWrap<cr>
nnoremap <silent> <leader>t :NERDTree<cr>
nnoremap <silent> <leader>w :ArgWrap<cr>
nnoremap <silent> <leader>v :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>s :source $MYVIMRC<cr>
nnoremap <silent> <leader>T :call RunTests()<cr>
" quick rot13 all
nnoremap ?? ggg?G``
nnoremap YQ ZQ
nnoremap YY ZZ
nnoremap Ä }
nnoremap Ö {
nnoremap Ü ;
nnoremap ä ]
nnoremap ö [
nnoremap ü :

vnoremap <expr> <down> DVB_Drag('down')
vnoremap <expr> <left> DVB_Drag('left')
vnoremap <expr> <right> DVB_Drag('right')
vnoremap <expr> <up> DVB_Drag('up')
vnoremap <expr> D DVB_Duplicate()
vnoremap cx <esc>cxgv
vnoremap <silent> <leader>s :sort<cr>

colorscheme flattened_dark
