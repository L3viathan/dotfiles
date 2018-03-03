" .vimrc

" OPTIONS
set nocp                        " turn off Vi-compatibility
set ai                          " automatically indent if necessary
set bs=2                        " backspace over lines
set bdir=~/.vim/backup          " write backupfiles to central dir
" set cul                       " highlight cursor line. Taken out: lag
set enc=utf-8                   " UTf-8 always, everywhere
set noeb vb t_vb=               " shut up
set et                          " no literal tab characters
set fdm=manual                  " fold when I want to
set cc=80                       " color column 80
set hls is                      " search immediately and highlight
set nojs                        " single space after .!?
set ls=2                        " necessary for lightline
set lz                          " don't redraw screen during macros
set list                        " show whitespace with special chars:
set lcs=tab:▶\ ,trail:·,nbsp:⎵  " these.
set magic                       " default to magic mode in regex
set mouse=a                     " always enable mouse
set mps+=«:»,“:”                " additional matching pairs for %
set nu                          " show line numbers
set ru                          " show line and col number of cursor
set so=2                        " always show 2 lines of extra context
set sw=4 ts=4 sts=0             " indentation with 4 spaces
set shm=filmnrxsToOI            " shorter messages for some prompts
set sc                          " show command in last line
set sm                          " briefly jump to matching paren
set sta                         " tab and untab sw spaces
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttym=xterm2
endif
set udf                                 " write persistent undo file
set wig=*.o,*~,*.pyc                    " ignore in wild menu
set wmnu                                " enable wild menu
set wim=list:longest,full               " how to suggest in wild menu

colorscheme solarized

" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'lfv89/vim-interestingwords'
Plug 'altercation/vim-colors-solarized'
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', {'on': 'FZF', 'do': 'yes \| ./install' }
Plug 'w0rp/ale', {'for': 'python'}
Plug 'michaeljsmith/vim-indent-object'
Plug 'oblitum/rainbow'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive' " git stuff
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'matze/vim-move'
Plug 'shinokada/dragvisuals.vim'
Plug 'tommcdo/vim-exchange'
Plug 'drzel/vim-line-no-indicator'
Plug 'itchyny/lightline.vim'
call plug#end()
filetype plugin indent on    " required
syntax on


" ASSIGNMENTS (mostly for plugins)

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'right': [ [ 'lineinfo', 'linenoindicator' ],
  \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
  \ },
  \ 'component': {
  \   'charvaluehex': '0x%B',
  \   'linenoindicator': '%{LineNoIndicator()}'
  \ },
  \ }

let g:ackprg = 'ag --vimgrep'
let g:gitgutter_sign_added = '⊕'
let g:gitgutter_sign_removed = '⊖'
let g:gitgutter_sign_modified = '⊙'
let g:mapleader = " "
let g:move_key_modifier = 'C'
let g:rainbow_active = 1
let g:DVB_TrimWS = 1
let g:line_no_indicator_chars = [' ', '⠁', '⠉', '⠋', '⠛', '⠟', '⠿', '⡿', '⣿']

let hostname = substitute(system('hostname'), '\n', '', '')

let g:matchparen_timeout = 2
let g:matchparen_insert_timeout = 2


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

function AckAg()
    call inputsave()
    let search = input('> ')
    call inputrestore()
    execute 'Ack!' search
endfunction


" AUTOCMDS

autocmd BufWinEnter *.* silent loadview
autocmd BufWinLeave * call clearmatches()
autocmd BufWinLeave *.* mkview
autocmd filetype crontab setlocal nobackup nowritebackup


" MAPPINGS

map <C-c> ~
map <Down> <Nop>
map <silent> <Left> :bprevious<cr>
map <silent> <Right> :bnext<cr>
map <Up> <Nop>
map <leader>cd :cd %:p:h<cr>:pwd<cr>
map <leader>p "+p
map Q @q
map T ^
map Y y$
map <F1> <nop>
nmap cxgv `<cx`>
nmap s ys
nmap S yss
cmap w!! w !sudo tee % > /dev/null
vmap <expr> <left> DVB_Drag('left')
vmap <expr> <right> DVB_Drag('right')
vmap <expr> <up> DVB_Drag('up')
vmap <expr> <down> DVB_Drag('down')
vmap <expr> D DVB_Duplicate()
vmap cx <esc>cxgv

nnoremap ' `
nnoremap + <C-A>
nnoremap - <C-X>
nnoremap <C-P> :!python3 %<cr>
nnoremap <C-j> 3<C-e>
nnoremap <C-k> 3<C-y>
nnoremap <silent> <Space> za
nnoremap <silent> <leader><cr> :nohl<cr>
nnoremap <silent> <leader>H :Hexmode<CR>
nnoremap <silent> <leader>t :NERDTree<cr>
nnoremap <silent> <leader>n :ALENextWrap<cr>
nnoremap <silent> <leader>N :ALEPreviousWrap<cr>
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :call AckAg()<cr>
nnoremap <silent> <leader>T :NERDTreeClose<cr>
nnoremap <silent> <leader>M :MinimapToggle<cr>
nnoremap YQ ZQ
nnoremap YY ZZ
nnoremap ö [
nnoremap ä ]
nnoremap Ö {
nnoremap Ä }
nnoremap ü :
nnoremap Ü ;
" quick rot13 all
nnoremap ?? ggg?G``

cnoremap <C-A> <Home>
cnoremap <C-E> <End>

vnoremap <leader>s :sort<cr>
