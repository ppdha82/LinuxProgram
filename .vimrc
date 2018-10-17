" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
" Author: Gerhard Gappmeier
"
" auto reload .vimrc when changed, this avoids reopening vim
autocmd! bufwritepost .vimrc source %
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
" set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
set nowrapscan " 검색할 때 문서의 끝에서 처음으로 안돌아감
set visualbell " 키를 잘못눌렀을 때 화면 프레시
set incsearch "  키워드 입력시 점진적 검색할
"set ic			" 검색할 때 대/소문자 구분 안함. set noic : 대/소문자 구분함.
set makeprg=make

" define ',' is leader key
let mapleader = ","
" turn syntax highlighting on
syntax on
if has("gui_running")
    colorscheme darkblue
    "set gfn=DejaVu_Sans_Mono:h10:cANSI
	"set guifont=Monospace\ 10
	set gfn=Monospace\ 10
else
    set t_Co=256
    colorscheme pablo
endif
" show textwidth line
set colorcolumn=120
highlight ColorColumn ctermbg=236
" show trailing whitespaces
"match ExtraWS /\s\+$/
" highlight all search results
set hlsearch
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
" use intelligent file completion like in the bash
set wildmode=longest:full
set wildmenu
" allow changeing buffers without saving them
set hidden

" use our own intelligent make command
set makeprg=mk

" configure printer
set pdev=HP_Officejet_Pro_8600

" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" superTab
" uncomment the next line to disable superTab
"let loaded_supertab = 1

set completeopt=menu,longest
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabLongestHighlight=1
let g:SuperTabLongestEnhanced=1

" clang-complete
filetype plugin on
let g:clang_complete_copen = 1
let g:clang_use_library = 1
let g:clang_library_path = "/usr/lib64/llvm"
let g:clang_snippets = 1
let g:clang_conceal_snippets=1
let g:clang_snippets_engine = 'clang_complete'
let g:clang_complete_auto=1
let g:clang_periodic_quickfix=0
set conceallevel=2
set concealcursor=vin
" Limit popup menu height
set pumheight=20

" vim-git plugin
set laststatus=2
"set statusline=%{GitBranch()}

" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@return "
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Gerhard Gappmeier <gerhard.gappmeier@ascolab.com>"
"let g:DoxygenToolkit_licenseTag="My own license"
let g:DoxygenToolkit_interCommentTag = "*"
let g:indentLine_faster = 1

" Enhanced keyboard mappings
"
" unindent with Shift-Tab
imap <S-Tab> <C-o><<
" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR>i
" run Tlist and NERDTree
nmap <F3> :Tlist<CR> <C-w>h <C-w><S-l> <C-W>45\|:NERDTree<CR> <C-w>35\|
imap <F3> <ESC> :Tlist<CR> <C-w>h <C-w><S-l> <C-W>45\|:NERDTree<CR> <C-w>35\|
" recreate cscope file with F4
nmap <F4> :!mkcscope.sh<CR>
imap <F4> <ESC>:!mkcscope.sh<CR>
" recreate tags file with F5
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" create doxygen comment
"map <F6> :Dox<CR>
" execute cscope
nmap <F6> :!rscope.sh<CR>
imap <F6> <ESC>:!rscope.sh<CR>
" build using makeprg with <F7>
nmap <F7> :!make install -j8<CR>
" build using makeprg with <F7>, in insert mode exit to command mode, save and compile
imap <F7> <ESC>:w<CR>:!make install -j8<CR>
" build using makeprg with <S-F7>
nmap <S-F7> :!make clean<CR>
imap <S-F7> <ESC>:w<CR>:!make clean<CR>
map <C-F7> :!make gui rs485_422 net config -j8<CR>
"imap <C-F7> <ESC>:w<CR>:!make gui rs485_422 net config -j8<CR>
" run svn diff to diff text 
map <F8> : !svn diff > diff<CR>
map <S-F8> : !git diff > diff<CR>
" build all
map <F9> : !make -j8<CR>
map <S-F9> : !make install -j8<CR>
" remove trailing spaces
map <F10> :%s/\s\+$//<CR>
" goto definition with F12
map <F12> <C-]>
" open definition in new split
"map <S-F12> <C-W> <C-]>
map <S-F12> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" in diff mode we use the spell check keys for merging
if &diff
  " diff settings
  map <M-Down> ]c
  map <M-Up> [c
  map <M-Left> do
  map <M-Right> dp
  map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
else
  " spell settings
"  :setlocal spell spelllang=en
  " set the spellfile - folders must exist
  " global wordlist, press zg to add a word to the list
  set spellfile=~/.vim/spellfile.add
  " project specific ignore list, press 2zg to add a word to this ignore list
  set spellfile+=ignore.utf-8.add
  map <M-Down> ]s
  map <M-Up> [s
endif

" Taglist
let Tlist_WinWidth = 50

" airline
" use powerline fonts to show beautiful symbols
let g:airline_powerline_fonts = 1
" enable tab bar with buffers
let g:airline#extensions#tabline#enabled = 1
" fix the timout when leaving insert mode (see http://usevim.com/2013/07/24/powerline-escape-fix)
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=10
  augroup END
endif

" my macros
" surround variable name with ${...}
let @s='bi${ea}'
" implement method. Turns 'int foo();' into 'int foo()\n{\n}\n'

"au! Syntax mixed  so $vim/syntax/cmix.vim
let g:neocomplcache_enable_at_startup=1
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" Install Vundle
"set rtp+=~/.vim/bundle/Vundle.vim/
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'git://git.wincent.com/command-t.git'

Plugin 'ctags.vim'
Plugin 'taglist.vim'
Plugin 'The-NERD-tree'
Plugin 'pathogen.vim'
Plugin 'neocomplcache'

Plugin 'AutoComplPop'
Plugin 'snipMate'
"Plugin 'Source-Explorer-srcexpl.vim'
"Plugin 'mattn/emmet-vim'
"Plugin 'sudo.vim'

"Plugin 'HTML.zip'

"git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git ~/.vim/bundle/nerdtree-git-plugin
"Plugin 'nerdtree-git-plugin'

"git config --global diff.tool vimdiff
"git config --global merge.tool vimdiff
"git config --global difftool.prompt false
"git config --global alias.d difftool

"http://www.vim.org/scripts/script.php?script_id=1846
"Plugin 'git-diff'

"Plugin 'fugitive.vim'
"Plugin 'github-theme'
"Plugin 'gitvimdiff'
"Plugin 'git-commit'
"Plugin 'gitdiff.vim'
"Plugin 'gitvimrc.vim'

Plugin 'nanotech/jellybeans.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'tommcdo/vim-lion'

Plugin 'plasticboy/vim-markdown'
Plugin 'Yggdroot/indentLine'
Plugin 'jiangmiao/auto-pairs'
Plugin 'majutsushi/tagbar'
Plugin 'MultipleSearch'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'SirVer/ultisnips'
Plugin 'matchit.zip'
Plugin 'airblade/vim-rooter'
Plugin 'rking/ag.vim'

call vundle#end()
" pathogen
execute pathogen#infect()

" It happens so oftern that I type :Q instead of :q that it makes sense to make :Q just working. :Q is not used
" anyway by vim.
"command Q q
colorscheme jellybeans

