" Don't try to be vi compatible
set nocompatible
" Helps force plugins to load correctly when it is turned back on below
filetype off

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins (using junegunn/vim-plug)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Plug 'python-mode/python-mode'
" Plug 'Valloric/YouCompleteMe'
" Plug 'zchee/deoplete-jedi'  " I'm using LanguageClient
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'cakebaker/scss-syntax.vim'
Plug 'cfsalguero/perl-go-to-def'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'fisadev/vim-isort'
Plug 'flazz/vim-colorschemes'
Plug 'gabrielelana/vim-markdown'
Plug 'gmarik/Vundle.vim'
Plug 'isRuslan/vim-es6'
Plug 'janko-m/vim-test'
Plug 'janko-m/vim-test'
Plug 'junegunn/goyo.vim'
Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mgedmin/coverage-highlight.vim'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'slashmili/alchemist.vim'
Plug 'ternjs/tern_for_vim'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'twitvim/twitvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-python/python-syntax'
Plug 'vim-scripts/Conque-Shell'
Plug 'wellle/targets.vim'
Plug 'wincent/command-t'
Plug 'wting/gitsessions.vim'
Plug 'xolox/vim-misc'
Plug 'yegappan/mru'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

" Deoplete (Autocomplete)
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dirty hack for elixir files
" au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
" au BufRead,BufNewFile *.eex set filetype=eelixir

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

" Enable mouse use in normal mode
set mouse= "nv
"
" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
"set ttymouse=xterm2

set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir
set completeopt=longest,menuone
set showtabline=2
set path=.,,**

" Case sentive search only if the search word has an upppercase letter
" Both ignorecase and smartcase must be on to make this feature work
set ignorecase
set smartcase

let g:neomake_verbose=1
let g:neomake_logfile='/tmp/s'

" I'm not using YCM
" let g:ycm_always_populate_location_list = 0 "default 0
" let g:ycm_auto_trigger=1
" let g:ycm_complete_in_strings = 1 "default 1
" let g:ycm_enable_diagnostic_highlighting = 1
" let g:ycm_enable_diagnostic_signs = 1
" let g:ycm_key_invoke_completion = '<C-Space>'
" let g:ycm_min_num_of_chars_for_completion=3
" let g:ycm_open_loclist_on_ycm_diags = 1 "default 1
" let g:ycm_python_binary_path = 'python'
" let g:ycm_register_as_syntastic_checker = 1 "default 1

let g:Show_diagnostics_ui = 1 "default 1

let g:syntastic_mode_map = {
    \ 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['xml'] }
let g:syntastic_auto_loc_list = 0
let g:syntastic_go_checkers = ['gofmt', 'go', 'golint', 'govet', 'errcheck']
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl', 'podchecker']
let g:syntastic_python_checkers = ['pyflakes']
" let g:syntastic_python_checkers = ['flake8']

"""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"""""""

let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 0
let g:go_highlight_structs = 0
let g:go_fmt_command = "goimports"
"let g:go_list_type = "quickfix"

"air-line
let g:airline_theme = 'dark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 0

let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = ['\.pyc$']

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

" Solarized theme configuration
" See: https://stackoverflow.com/questions/23118916/configuring-solarized-colorscheme-in-gnome-terminal-tmux-and-vim
syntax enable
set t_Co=256
if has('gui_running')
    set background=light
else
    set background=dark
endif
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

" I think this is managed by solarized.vim:
" hi CursorLine term=none cterm=none ctermbg=Black
" hi TabLineFill ctermfg=White ctermbg=DarkGrey
" hi TabLine term=none cterm=none ctermfg=White ctermbg=DarkGrey
" hi TabLineSel term=none cterm=none ctermfg=White ctermbg=Blue

map  <C-Down>    <Esc><C-w><Down>
map  <C-Left>    <Esc><C-w><Left><CR>
map  <C-Right>   <Esc><C-w><Right><CR>
map  <C-S-Down>  :lnext<CR>
map  <C-S-Up>    :lprevious<CR>
map  <C-Up>      <Esc><C-w><Up>
map  <leader>h   <Esc>:noh<CR>
map  <C-j>       <Esc>:bprevious<CR>
map  <C-k>       <Esc>:bnext<CR>
map  <C-n>       :NERDTreeToggle<CR>
map  <C-x>       <Esc>:bp\|bd #<CR>
map  <Leader>n   :NERDTreeToggle<CR>
nmap ,d :b#<bar>bd#<CR>

" " YouCompleteMe
" nnoremap <Leader>a    :YcmCompleter GoToDefinitionElseDeclaration<CR>
" nnoremap <Leader>s    :YcmCompleter GoToDeclaration<CR>
" nnoremap <Leader>d    :YcmCompleter GoToDefinition<CR>
" nnoremap <Leader>/    :YcmCompleter GoToInclude<CR>

" Language Client
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <leader>a :call LanguageClient#textDocument_implementation()<CR>
nnoremap <silent> <leader>a :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" :w!! will write read only files not opened with sudo
cmap w!! w !sudo tee % >/dev/null

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if exists('+colorcolumn')
  set colorcolumn=80
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

""""""""""""""""""""""""""
"" CtrlP configuration  ""
""""""""""""""""""""""""""
" Lets improve ctrlp performance
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
nmap <leader><leader> :CtrlP<cr>
nmap <leader>. :CtrlPLine<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
nmap <leader>bt :CtrlPTag<cr>

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

" Tagbar
nmap <leader><Space> :TagbarToggle<CR>
autocmd VimEnter * nested :call tagbar#autoopen(1)
" autocmd FileType * nested :call tagbar#autoopen(0)

" Python
let g:python_highlight_all=1
" let g:loaded_python3_provider=1

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

nnoremap <silent> <leader>f :echo expand('%:p')<CR>


let g:LanguageClient_serverCommands = {
    \ 'python': ['/usr/local/bin/pyls'],
    \ }

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
        lclose
        unlet g:qwindow
    else
        try
            lopen 10
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

" Coverage plugin options
noremap [C :<C-U>PrevUncovered<CR>
noremap ]C :<C-U>NextUncovered<CR>

" Automatically remove trailing whitespaces on lines
autocmd BufWritePre *.py %s/\s\+$//e

" json-vim has the terrible idea to hide quotes by default
let g:vim_json_syntax_conceal = 0
