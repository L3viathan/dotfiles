" .vimrc

" OPTIONS
set autoindent                  " automatically indent if necessary
set backspace=2                 " backspace over lines
set backupdir=~/.vim/backup     " write backupfiles to central dir
set background=dark
" set cursorline                " highlight cursor line. Taken out: lag
set encoding=utf-8              " UTF-8 always, everywhere
set noerrorbells visualbell t_vb=  " shut up
set expandtab                   " no literal tab characters
set conceallevel=2              " turn on full conceal mode
set foldmethod=manual           " fold when I want to
set colorcolumn=80,81,82,83,84,85,86,87,88,89
set hidden                      " allow switching buffers with unsaved changes
set incsearch hlsearch          " search immediately and highlight
set nojoinspaces                " single space after .!?
set laststatus=2                " necessary for lightline
set lazyredraw                  " don't redraw screen during macros
set list                        " show whitespace with special chars:
set listchars=tab:▶\ ,trail:·,nbsp:⎵   " these.
set magic                       " default to magic mode in regex
set mouse=
set matchpairs+=«:»,“:”         " additional matching pairs for %
set number                      " show line numbers
set relativenumber              " show relative line numbers
set ruler                       " show line and col number of cursor
set scrolloff=2                 " always show 2 lines of extra context
set shortmess=filmnrxsToOI      " shorter messages for some prompts
set showcmd                     " show command in last line
set showmatch                   " briefly jump to matching paren
set noshowmode                  " don't show mode (because lightline shows it)
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif
set undofile undodir=~/.vim/undo  " write persistent undo file
set viewoptions=cursor,folds    " don't save options on mkview
set wildignore=*.o,*~,*.pyc     " ignore in wild menu
set wildmenu                    " enable wild menu
set wildmode=list:longest,full  " how to suggest in wild menu
set timeoutlen=1000 ttimeoutlen=0

" PLUGINS
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'FooSoft/vim-argwrap'
Plug 'psf/black', {'for': 'python', 'branch': 'stable' }
Plug 'L3viathan/flattened'
Plug 'L3viathan/vim-autoswap'
Plug 'Olical/vim-enmasse'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'christoomey/vim-sort-motion'
Plug 'drzel/vim-line-no-indicator'
" Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'junegunn/fzf', {'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 't9md/vim-quickhl'
Plug 'markonm/traces.vim'
Plug 'zivyangll/git-blame.vim'
Plug 'matze/vim-move'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mileszs/ack.vim'
Plug 'L3viathan/vim-rainbow'
Plug 'rhysd/committia.vim'
Plug 'gavinbeatty/dragvisuals.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'tpope/vim-abolish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'w0rp/ale', {'for': ['python', 'sh']}
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'ap/vim-buftabline'
Plug 'AndrewRadev/switch.vim'
Plug 'mattn/emmet-vim', {'for': 'html'}
Plug 'lervag/vimtex', {'for': 'latex'}
Plug 'zah/nim.vim'
Plug 'vim-scripts/vis'
Plug 'posva/vim-vue'
Plug 'Konfekt/FastFold'
Plug 'lervag/wiki.vim'
Plug 'pechorin/any-jump.vim'
Plug 'unblevable/quick-scope'
Plug 'simnalamburt/vim-mundo'
Plug 'wellle/context.vim'
Plug 'wincent/terminus'
" Plug 'tpope/vim-sleuth'
Plug 'christoomey/vim-tmux-runner'
Plug 'sheerun/vim-polyglot'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vimsence/vimsence'
call plug#end()


" ASSIGNMENTS (mostly for plugins)

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'right': [
  \     [ 'charvaluehex', 'lineinfo', 'linenoindicator' ],
  \     [ 'fileformat', 'fileencoding', 'filetype'],
  \     [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \   ]
  \ },
  \ 'component': {
  \   'charvaluehex': '0x%B',
  \   'linenoindicator': '%{LineNoIndicator()}',
  \ },
  \ 'component_expand': {
  \   'linter_checking': 'lightline#ale#checking',
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \   'linter_ok': 'lightline#ale#ok',
  \ },
  \ 'component_type': {
  \   'linter_checking': 'left',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'left',
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

let g:ale_linters = {'python': ['ruff']}
let g:ale_fixers = {'python': ['black', 'ruff']}
let g:ale_set_balloons = 0  " fixes an issue that occurs when ttymouse=xterm2
let g:ackprg = 'rg --vimgrep'
let g:autoswap_detect_tmux = 1
" let g:black_linelength = 80
let g:gitgutter_sign_added = '⊕'
let g:gitgutter_sign_removed = '⊖'
let g:gitgutter_sign_modified = '⊙'
let g:lightline#ale#indicator_checking = "…"
let g:lightline#ale#indicator_warnings = "W"
let g:lightline#ale#indicator_errors = "E"
let g:lightline#ale#indicator_ok = "✓"
let g:mapleader = " "
let g:move_key_modifier = 'C'
let g:rainbow_active = 1
let g:rainbow_ctermfgs = [1, 2, 3, 4, 5, 6, 7, 9]
let g:DVB_TrimWS = 1
let g:line_no_indicator_chars = [' ', '⠁', '⠉', '⠋', '⠛', '⠟', '⠿', '⡿', '⣿']
let g:rooter_silent_chdir = 1
let g:SuperTabDefaultCompletionType = 'context'
let g:surround_92 = "\1literally: \1\r\1\1"  " surround with anything with backslash
let g:switch_mapping = '\'
let g:vimtex_compiler_latexmk = {
        \ 'backend' : 'jobs',
        \ 'background' : 1,
        \ 'build_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \   '-verbose',
        \   '-xelatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}

let g:VtrInitialCommand = 'python'
let g:VtrStripLeadingWhitespace = 0
let g:VtrAppendNewline = 1
let g:VtrAutomaticReattachByName = 1

let g:wiki_root = '~/vimwiki'

let g:jira_host = 'https://jira.solute.de'
let g:jira_user = 'jo'

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
    let search = "'" . input('> ') . "'"
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


function! TrimTrailing()
    let curpos = getpos(".")
    let oldsearch = @/
    %s/\v\s+$//e
    nohlsearch
    let @/ = oldsearch
    call setpos(".", curpos)
endfun

function! ToggleBreakpoint()
    let line = getline('.')
    if line =~# 'breakpoint'
        delete
    else
        normal obreakpoint()
    endif
endfun

function! Blackify(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    if a:type == 'line'
        exe "normal! :'[,']!black --quiet -<cr>"
    else
        exe "normal! :`[,`]!black --quiet -<cr>"
    endif

    let &selection = sel_save
    let @@ = reg_save
endfun

function! CamelCase(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    if a:type == 'line'
        silent exe "normal! :'[,']s#\\(\\%(\\<\\l\\+\\)\\%(_\\)\@=\\)\\|_\\(\\l\\)#\\u\\1\\2#g<cr>"
    else
        normal `[v`]y
        let text = @@
        let text = substitute(text, '\(_\|\<\)\(\w\)', '\u\2', 'g')
        let @@ = text
        normal `[v`]p`[
    endif

    let &selection = sel_save
    let @@ = reg_save
endfun

function! SnakeCase(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    if a:type == 'line'
        silent exe "normal! :'[,']s#\\(\\<\\u\\l\\+\\|\\l\\+\\)\\(\\u\\)#\\l\\1_\\l\\2#g<cr>"
    else
        normal `[v`]y
        let text = @@
        let text = substitute(text, '\<\(.\)', '\l\1', 'g')
        let text = substitute(text, '\(\u\)', '_\l\1', 'g')
        let @@ = text
        normal `[v`]p`[
    endif

    let &selection = sel_save
    let @@ = reg_save
endfun

" https://gist.github.com/romainl/3b8cdc6c3748a363da07b1a625cfc666
function! BreakHere()
    s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
    call histdel("/", -1)
endfunction

function! CountMinutes()
    let old_reg=getreg("a")
    let old_reg_type=getregtype("a")
    let @a=''
    silent! %s/[+-]\d\+\zemin/\=setreg('A', submatch(0))/gn
    let minutes=eval(getreg("a"))
    echo minutes . " minutes"
    call setreg("a", old_reg, old_reg_type)
endfunction

function! GitBlameLine()
  call printf("git blame -s -L %s,%s -- %s | head -c 8", line('.'), line('.'), expand('%'))
        \ ->system()
        \ ->printf("git log --stat -1 %s")
        \ ->system()
        \ ->split("\n")
        \ ->popup_atcursor({ "padding": [0, 1, 1, 1] })
endfunc

" AUTOCMDS
augroup vimrc
    autocmd!
    autocmd BufWinEnter *.* silent loadview
    autocmd BufWinLeave * call clearmatches()
    autocmd BufWinLeave *.* mkview
    autocmd FileType crontab setlocal nobackup nowritebackup
    autocmd BufRead * call SetTrailing()
    autocmd FileType qf nnoremap <leader>M :EnMasse<cr>
    autocmd FileType python let b:switch_custom_definitions =
    \ [
    \    ['True', 'False', 'None'],
    \    ['return', 'yield'],
    \    ['.debug', '.info', '.warning', '.error', '.exception', '.critical'],
    \    ['@property', '@staticmethod', '@classmethod'],
    \    ['foo', 'bar', 'bat', 'baz', 'spam', 'ham', 'eggs', 'bacon'],
    \    {
    \      '\v^from ([^ ]+) import ([^ ]+)$': 'import \1.\2',
    \      '\v^import ([^ ]+)\.([^ .]+)$': 'from \1 import \2',
    \    }
    \ ]
augroup END


" MAPPINGS

" noremap <C-c> ~
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
nmap ga <Plug>(EasyAlign)
nmap gR gr$
nmap <leader>w<leader>n <Plug>(wiki-journal-next)
nmap <leader>w<leader>p <Plug>(wiki-journal-prev)
nmap <leader>wc :call CountMinutes()<cr>
nmap <leader>k <Plug>(quickhl-manual-this)
nmap <leader>K <Plug>(quickhl-manual-reset)
nnoremap <silent> K <C-]>
nnoremap + <C-A>
nnoremap - <C-X>
nnoremap <silent> <C-X> :bd<cr>
nnoremap <C-P> :!clear ; python3 %<cr>
nnoremap g<C-P> :terminal ++close python3<cr>
nnoremap g<C-I> :!clear ; pygmentize -g % ; python3 -i %<cr>
nnoremap g/ /\</\><cr>
nnoremap <silent> <leader><cr> :nohl<cr>
nnoremap <silent> <leader>F :call AckAg()<cr>
nnoremap <silent> <leader>H :Hexmode<CR>
nnoremap <silent> <leader>N :ALEPreviousWrap<cr>
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>l :call TrimTrailing()<cr>
nnoremap <silent> <leader>n :ALENextWrap<cr>
nnoremap <silent> <leader>w :ArgWrap<cr>
nnoremap <silent> <leader>v :split $MYVIMRC<cr>
nnoremap <silent> <leader>s :source $MYVIMRC<cr>
nnoremap <silent> <leader>t :silent !ctags -R --languages=python .<cr>:redraw!<cr>
nnoremap <silent> <leader>gT :Tags<cr>
nnoremap <silent> <leader>gt :BTags<cr>
nnoremap <silent> <leader>gb :Buffers<cr>
nnoremap <silent> <leader>gf :Files<cr>
nnoremap <silent> <leader>gg :GFiles<cr>
nnoremap <silent> <leader>gl :Lines<cr>
nnoremap <silent> <leader>gm :Marks<cr>
nnoremap <silent> <leader>Gb :call GitBlameLine()<cr>
nnoremap <silent> <leader>b :call ToggleBreakpoint()<cr>
nnoremap <silent> <leader>B :<C-u>call gitblame#echo()<cr>
nnoremap <silent> <leader>== :ALEFix<cr>
nnoremap <silent> <leader>00 :Black<cr>
nnoremap <silent> <leader>= :set opfunc=Blackify<cr>g@
nnoremap <silent> <leader>cs :set opfunc=SnakeCase<cr>g@
nnoremap <silent> <leader>css :set opfunc=SnakeCase<cr>0g@$
nnoremap <silent> <leader>cscs :set opfunc=SnakeCase<cr>0g@$
nnoremap <silent> <leader>cc :set opfunc=CamelCase<cr>g@
nnoremap <silent> <leader>ccc :set opfunc=CamelCase<cr>0g@$
nnoremap <silent> <leader>J <C-u>call BreakHere()<cr>
" quick rot13 all
nnoremap <leader>? ggg?G``
nnoremap YQ ZQ
nnoremap YY ZZ
nnoremap <leader>ro :VtrOpenRunner<cr>
nnoremap <leader>rr :VtrSendLinesToRunner<cr>j
vnoremap <leader>rr :VtrSendLinesToRunner<cr>
nnoremap <leader>rF :VtrFocusRunner<cr>
nnoremap <leader>rf :VtrFocusRunner!<cr>
nnoremap <leader>rc :VtrKillRunner<cr>

vnoremap <expr> <down> DVB_Drag('down')
vnoremap <expr> <left> DVB_Drag('left')
vnoremap <expr> <right> DVB_Drag('right')
vnoremap <expr> <up> DVB_Drag('up')
vnoremap <expr> D DVB_Duplicate()
vnoremap cx <esc>cxgv
vnoremap <silent> <leader>s :sort<cr>
vnoremap <silent> <leader>= :!black --quiet -<cr>

xmap ga <Plug>(EasyAlign)
xmap <leader>k <Plug>(quickhl-manual-this)
xmap <leader>K <Plug>(quickhl-manual-reset)

command! W w

iabbr inim if __name__ == '__main__':<cr>    cli()

colorscheme flattened_dark
highlight Comment ctermbg=Black ctermfg=DarkRed
set makeprg=latexmk\ -f\ -xelatex\ -interaction=nonstopmode\ %
nnoremap <silent> <leader>ll :make<cr>

try
    source ~/.vimrc.local
catch
    " 404
endtry
