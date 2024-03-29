set nocompatible  " Don't try to be vi-compatible (nvim is always nc)
" Helps force plugins to load correctly when it is turned back on below
filetype off

let g:python_host_prog = '/home/manuel/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/manuel/.pyenv/versions/neovim3/bin/python'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS (using junegunn/vim-plug)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'       " Universal set of defaults that (hopefully) everyone can agree on.
Plug 'airblade/vim-gitgutter'   " Shows a git diff in the gutter and stages/undoes hunks.
" Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'       " Fuzzy file, buffer, mru, tag, etc finder.
Plug 'elzr/vim-json'            " A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing.
Plug 'fisadev/vim-isort'        " pip install isort -- Intelligent import sorting
Plug 'flazz/vim-colorschemes'
Plug 'gabrielelana/vim-markdown'
Plug 'janko-m/vim-test'         " A Vim wrapper for running tests on different granularities.
Plug 'junegunn/goyo.vim'        " Distraction-free writing in Vim
Plug 'kshenoy/vim-signature'    " Plugin to toggle, display and navigate marks
Plug 'mgedmin/coverage-highlight.vim'
Plug 'pangloss/vim-javascript'  " Because sometimes you need to get dirty
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'        " Integration with GitHub
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-python/python-syntax'
" Plug 'wellle/targets.vim'  "TODO: Seems very similar to sorround.vim. Investigate
" Plug 'wincent/command-t'  " TODO: Why you need this if you have CTRL-P?
Plug 'wincent/loupe'
Plug 'wting/gitsessions.vim'
Plug 'junegunn/fzf'             " Multi-entry selection UI.
" Plug 'embark-theme/vim', { 'as': 'embark' }
" Plug 'statox/FYT.vim'
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete (Autocomplete) """""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Used by LanguageClient instead of omnicompletion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Snippets
Plug 'sirver/ultisnips'
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
if !exists('g:started_by_firenvim')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'enricobacis/vim-airline-clock'
endif

if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Initialize plugin system
call plug#end()

try
" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

syntax on
filetype plugin indent on " required for plugins to load correctly

" Mapleader keys and jj -> ESC
let mapleader = ","
imap jj <Esc>

" Security
set modelines=0

" Blink cursor on error instead of beeping
set visualbell

" Encoding
set encoding=utf-8

" Send more characters for redraws
set ttyfast

" start scroll before reach the screen limit
set scrolloff=3

set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir
set completeopt=longest,menuone
set showtabline=2
set path+=**

" Case sentive search only if the search word has an upppercase letter
" Both ignorecase and smartcase must be on to make this feature work
set ignorecase
set smartcase

let g:neomake_verbose=1
let g:neomake_logfile='/tmp/s'

"" GO Language
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 0
let g:go_highlight_structs = 0
let g:go_fmt_command = "goimports"
"let g:go_list_type = "quickfix"


" Plugin: Syntastic
let g:syntastic_mode_map = {
    \ 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['xml'] }
let g:syntastic_auto_loc_list = 0
let g:syntastic_go_checkers = ['gofmt', 'go', 'golint', 'govet', 'errcheck']
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl', 'podchecker']
let g:syntastic_python_checkers = ['pyflakes']
" let g:syntastic_python_checkers = ['flake8'] ", 'mypy']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Plugin: air-line
let g:airline_theme = 'minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 1

" Plugin: NERDTree
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = ['\.pyc$', '\.egg-info$', '__pycache__', '__pycache__']
map <C-n> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: CTRLP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lets improve ctrlp performance
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|pyc)$',
\}

" Use the nearest .git directory as the cwd
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_switch_buffer='v'  " jump when <cr> is pressed, but only to windows
                               " in the current tab, except <c-v> is pressed

" Use a leader instead of the actual named binding
nmap <leader><leader> :CtrlPMixed<cr>
" nmap <leader>. :CtrlPLine<cr>
nmap <leader>. :CtrlPLine<cr>
nmap <leader>m :CtrlPMRU<cr>

" Easy bindings for its various modes
" nmap <leader>bb :CtrlPBuffer<cr>
" nmap <leader>bm :CtrlPMixed<cr>
" nmap <leader>bt :CtrlPTag<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_default_to_last = 1

au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.go set filetype=go

" To speed up GitSessions
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

let g:SignatureMarkerTextHLDynamic=1

set autoindent
set backspace=2
set cursorline
set foldlevelstart=20
set foldmethod=indent
set hidden
set history=150
set hlsearch
set laststatus=2
set nostartofline
set number
set showmatch
set tags=.tags
set virtualedit=all

" Whitespace
set nowrap
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color-related configurations
" Solarized theme configuration
" See: https://stackoverflow.com/questions/23118916/configuring-solarized-colorscheme-in-gnome-terminal-tmux-and-vim
" syntax enable
" set t_Co=256
" if has('gui_running')
"     set background=light
" else
"     set background=dark
" endif
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" colorscheme solarized

" I think this is managed by solarized.vim:
" hi CursorLine term=none cterm=none ctermbg=Black
" hi TabLineFill ctermfg=White ctermbg=DarkGrey
" hi TabLine term=none cterm=none ctermfg=White ctermbg=DarkGrey
" hi TabLineSel term=none cterm=none ctermfg=White ctermbg=Blue

set t_Co=256
set termguicolors
set background=dark
" colorscheme embark
colorscheme gruvbox
" let g:terminal_color_0  = '#151515'
" let g:terminal_color_1  = '#a53c23'
" let g:terminal_color_2  = '#7b9246'
" let g:terminal_color_3  = '#d3a04d'
" let g:terminal_color_4  = '#6c99bb'
" let g:terminal_color_5  = '#9f4e85'
" let g:terminal_color_6  = '#7dd6cf'
" let g:terminal_color_7  = '#d0d0d0'
" let g:terminal_color_8  = '#505050'
" let g:terminal_color_9  = '#a53c23'
" let g:terminal_color_10 = '#7b9246'
" let g:terminal_color_11 = '#d3a04d'
" let g:terminal_color_12 = '#547c99'
" let g:terminal_color_13 = '#9f4e85'
" let g:terminal_color_14 = '#7dd6cf'
" let g:terminal_color_15 = '#f5f5f5'


map  <C-Down>    <Esc><C-w><Down>
map  <C-Left>    <Esc><C-w><Left><CR>
map  <C-Right>   <Esc><C-w><Right><CR>
map  <C-S-Down>  :lnext<CR>
map  <C-S-Up>    :lprevious<CR>
map  <C-Up>      <Esc><C-w><Up>
map  <leader>h   <Esc>:noh<CR>
map  <C-j>       <Esc>:bprevious<CR>
map  <C-k>       <Esc>:bnext<CR>
map  <C-h>       <Esc>:tabp<CR>
map  <C-l>       <Esc>:tabn<CR>
map  <C-x>       <Esc>:bp\|bd #<CR>
nmap ,d :b#<bar>bd#<CR>
nmap <Leader>c   :ToggleCoverage<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LanguageClient
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
" nnoremap ggs :call LanguageClient#workspace_symbol()<CR>
nnoremap <silent> <leader>i :call LanguageClient#textDocument_implementation()<CR>
nnoremap <silent> <leader>a :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>f :call LanguageClient#textDocument_formatting()<CR>
vnoremap <silent> <leader>f :call LanguageClient#textDocument_rangeFormatting()<CR>
nnoremap <silent> <leader>_ :call LanguageClient#textDocument_documentHighlight()<CR>
nnoremap <silent> <leader>- :call LanguageClient#clearDocumentHighlight()<CR>
" nnoremap <silent> <leader>? :call LanguageClient#explainErrorAtPoint()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Git blame at line
nmap <silent><Leader>? :call setbufvar(winbufnr(popup_atcursor(systemlist("cd " . shellescape(fnamemodify(resolve(expand('%:p')), ":h")) . " && git log --no-merges -n 1 -L " . shellescape(line("v") . "," . line(".") . ":" . resolve(expand("%:p")))), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })), "&filetype", "git")<CR>

" :w!! will write read only files not opened with sudo
cmap w!! w !sudo tee % >/dev/null

" TODO: What is this doing?
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if exists('+colorcolumn')
  set colorcolumn=80,120
  " highlight ColorColumn ctermbg=magenta
  " call matchadd('ColorColumn', '\%81v', 100)
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Quickfix fixs  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1. Skip quickfix buffer when cycling through buffers
augroup qf
  autocmd!
  autocmd FileType qf set nobuflisted
augroup END

" 2. Skip quickfix buf when cycling through windows
:nnoremap <silent> <C-w><C-w> <C-w><C-w>:if &buftype ==# 'quickfix'<Bar>wincmd w<Bar>endif<CR>

" 3. Quickfix full width
" au FileType qf wincmd J

" set switchbuf=split
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Run this file
nnoremap <leader>r :!%:p<cr>
command RemoveTrailingSpaces %s/\s\+$//e

" Buffer movements
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" Location movements
nnoremap <silent> [l :lprev<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>

" Quickfix movements
nnoremap <silent> [e :cprev<CR>
nnoremap <silent> ]e :cnext<CR>
nnoremap <silent> [E :cfirst<CR>
nnoremap <silent> ]E :clast<CR>

" Swaping ; and : to fast access to colon commands
" nnoremap ; :
"nnoremap : ;

" Show me current buffer filename
nnoremap <silent> <leader>f :echo expand('%:p')<CR>

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python_version_2=1
let g:python_highlight_all=1
" let g:python_highlight_func_calls=0
" let g:loaded_python3_provider=1

" Coverage plugin options
noremap [C :<C-U>PrevUncovered<CR>
noremap ]C :<C-U>NextUncovered<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Language Client configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    \ 'python': ['docker-compose', 'run', '--rm', 'sc', 'python', '-m', 'pyls'],
"    \ 'python': ['/home/manuel/.pyenv/shims/pyls'],
"    \ 'python': ['/home/manuel/.pyenv/versions/pyls-27/bin/pyls'],
let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')
let g:LanguageClient_serverCommands = {
    \ 'python': ['/home/manuel/.pyenv/shims/pyls'],
    \ 'javascript': ['/home/manuel/.nvm/versions/node/v14.8.0/bin/node', '/home/manuel/dev/language-servers/javascript-typescript-langserver/lib/language-server-stdio'],
    \ }
let g:LanguageClient_useVirtualText = "No"
let g:LanguageClient_settingsPath = '/home/manuel/dev/dotvim/.vim/settings.json'

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c,py call SetLSPShortcuts()
augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Relative numbers
set number
set norelativenumber
augroup numbertoggle
  autocmd!
  let buftype_blacklist = ['terminal', 'nofile']
  autocmd BufEnter,WinEnter,FocusGained,InsertLeave * if index(buftype_blacklist, &buftype) < 0 | set relativenumber
  autocmd BufLeave,WinNew,WinLeave,FocusLost,InsertEnter * if index(buftype_blacklist, &buftype) < 0 | set norelativenumber
  " No relative numbers in terminal
  autocmd BufWinEnter,WinEnter,TermOpen,FocusGained term://* setlocal norelativenumber
  autocmd BufWinEnter,WinEnter,TermOpen,FocusGained term://* setlocal nonumber
  autocmd BufWinEnter,WinEnter,TermOpen,FocusGained term://* setlocal signcolumn=no
augroup END


" Toggle L/Q windows open/close
function! ToggleQuickFix()
    if exists("g:qwindow")
        cclose
        unlet g:qwindow
    else
        try
            copen 10
            let g:qwindow = 1
        catch
            echo "No Errors found!"
        endtry
    endif
endfunction

nmap <script> <silent> <F2> :call ToggleQuickFix()<CR>

" Folding
nnoremap <space> za
vnoremap <space> zf

" System Clipboard
vnoremap <C-c> "+y

" Rye templates
autocmd BufRead,BufNewFile /opt/pythonenv/v2_ordergroove-py27/templates/api/order_xml/* set syntax=htmldjango

" Automatically remove trailing whitespaces on lines
autocmd BufWritePre *.py %s/\s\+$//e

" json-vim has the terrible idea to hide quotes by default
let g:vim_json_syntax_conceal = 0

nnoremap <leader>b oimport ipdb; ipdb.set_trace()<ESC>

"" Spelling corrections
setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
autocmd BufRead,BufNewFile *.json set nospell

" Count number of matches of last search
"   (https://vim.fandom.com/wiki/Count_number_of_matches_of_a_pattern)
map ,* *<C-O>:%s///gn<CR>

" Search in visual mode
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" Moving lines around
nmap <M-k> :m-2<CR>
nmap <M-j> :m+<CR>
vmap <M-k> :m-2<CR>
vmap <M-j> :m'>+<CR>

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab



" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

