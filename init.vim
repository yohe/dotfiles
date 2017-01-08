" My .vimrc
" Note:
"   Coding Rule
"   1 Section composition
"     * Vim Basic Setting
"     * Plugin Setting
"     * Script Setting (Function, Command, etc)
"     * Keymapping Setting
"     * Editor Setting
"
"   2 the section header is described as follows.
"    
"     "-------------------------------------------------------------
"     " SECTION NAME 
"     "-------------------------------------------------------------
"      ^ "-" is 60 types
"
"   3 section is consists of "subsection"
"     
"     the subsection header is described as follows.
"     this header is maximum of 59 characters
"
"     "================== SUBSECTION NAME ==================
"
"   4 section is marker level 1.
"     and subsection is marker level 2.
"

"-------------------------------------------------------------
" 基本設定 Basic {{{1
" ------------------------------------------------------------
let mapleader = "_"

set nocompatible
set backspace=indent,eol,start
set t_Co=256

"-------------------------------------------
" 変数定義 {{{2
"-------------------------------------------
let s:backup_dir = expand("~/.config/nvim/vim_backup")
let s:swap_dir = expand("~/.config/nvim/vim_swap")
let s:plugins_dir = expand('~/.config/nvim/bundle')
let s:dein_dir = s:plugins_dir . '/Shougo/dein.vim'

"}}}

if has('mouse')
  set mouse=a
endif

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" backup and swap
if !isdirectory(s:backup_dir)
  call mkdir(s:backup_dir)
endif
set backup
execute 'set backupdir='.s:backup_dir
if !isdirectory(s:swap_dir)
  call mkdir(s:swap_dir)
endif
set swapfile
execute 'set directory='.s:swap_dir

syntax enable
"set ttymouse=xterm

" set statusline
set laststatus=2
set statusline=%<%f%y[%{&fenc}:%{&ff}]\ %h%m%r%=%-14.(%l-%L:%c%V%)\ %P

set listchars=tab:>.,trail:-,eol:$,nbsp:%

" gui setting reload
if has('gui_macvim')
    source $MYGVIMRC
endif

if has('nvim')
  tnoremap <silent> <ESC> <C-\><C-n>
endif

" インクリメントのフォーマットを10進固定にする
" set nrformats=octal,hex (デフォルト設定) etc: alpha
set nrformats=

set modeline
set modelines=5
set completeopt-=preview
set clipboard+=unnamed
"}}}


"-------------------------------------------------------------
" Plugin Setting {{{1
"-------------------------------------------------------------

" ==================== dein setting ================ {{{2
if &compatible
  set nocompatible
endif
execute 'set runtimepath+=' . s:dein_dir

call dein#begin(s:plugins_dir)

call dein#add("Shougo/dein.vim")
call dein#add("Shougo/deoplete.nvim")
call dein#add('vim-scripts/Colour-Sampler-Pack')
call dein#add('vim-scripts/svn-diff.vim')
call dein#add('surround.vim')
call dein#add('textobj-user')
call dein#add('textobj-fold')
call dein#add('vim-jp/vital.vim')
call dein#add('mattn/gist-vim')
call dein#add('mattn/webapi-vim')
call dein#add('vim-scripts/CCTree')
call dein#add('osyo-manga/shabadou.vim')
call dein#add('osyo-manga/vim-watchdogs')
call dein#add('kassio/neoterm')
call dein#add('vim-scripts/project.tar.gz')
call dein#add('Shougo/unite.vim')
call dein#add('thinca/vim-quickrun')
call dein#add('vim-scripts/open-browser.vim')
call dein#add('Shougo/vimfiler')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/denite.nvim')
call dein#add('Shougo/vimproc')
call dein#add('zchee/deoplete-clang')

call dein#end()

filetype plugin indent on
syntax enable

"}}}
"==================================================================
" プラグインの設定はこれ以降に記載する
"==================================================================

" =============== Deoplete Setting =========== {{{2
let g:deoplete#enable_at_startup=1
" Use smartcase.
let g:deoplete#enable_smart_case = 1

let g:deoplete#auto_complete_start_length=4

"let g:deoplete#omni_patterns = {}
"let g:deoplete#omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" 補完候補の中から共通部分を保管
inoremap <expr><C-h>        deoplete#smart_close_popup() . "\<C-h>"
inoremap <expr><BS>        deoplete#smart_close_popup() . "\<C-h>"

"}}}

" =============== Unite Setting =========== {{{2
let g:unite_source_menu_menus = {}
let g:unite_source_menu_menus.vimrc = {
      \     'description' : 'Edit vimrc',
      \ }
let g:unite_source_menu_menus.vimrc.candidates = {
      \   '~/.vimrc'      : 'edit ~/.vimrc',
      \   '~/.gvimrc'      : 'edit ~/.gvimrc',
      \ }
function g:unite_source_menu_menus.vimrc.map(key, value)
  return {
      \       'word' : a:key, 'kind' : 'command',
      \       'action__command' : a:value,
      \  }
endfunction

let g:unite_source_menu_menus.grep= {
      \     'description' : 'Search keyword.',
      \ }
let g:unite_source_menu_menus.grep.candidates = {
      \   'buffer'    : 'Unite grep:%:: -auto-preview -start-insert',
      \   'buffer all'    : 'Unite grep:$buffers:: -auto-preview -start-insert',
      \   'directory'    : 'Unite grep::: -auto-preview -start-insert',
      \ }
function g:unite_source_menu_menus.grep.map(key, value)
  return {
      \       'word' : a:key, 'kind' : 'command',
      \       'action__command' : a:value,
      \  }
endfunction

let g:unite_source_menu_menus.open_file= {
      \     'description' : 'Open file',
      \ }
let g:unite_source_menu_menus.open_file.candidates = {
      \   'file'    : 'Unite file_ref/async -auto-preview -start-insert',
      \   'file mru'    : 'Unite file_mru -auto-preview -start-insert',
      \   'bookmark'    : 'Unite bookmark',
      \ }
function g:unite_source_menu_menus.open_file.map(key, value)
  return {
      \       'word' : a:key, 'kind' : 'command',
      \       'action__command' : a:value,
      \  }
endfunction

let g:unite_source_menu_menus.tools= {
      \     'description' : 'Tools',
      \ }
let g:unite_source_menu_menus.tools.candidates = {
      \   'outline'    : 'Unite outline',
      \   'taglist'    : 'Tlist',
      \ }
function g:unite_source_menu_menus.tools.map(key, value)
  return {
      \       'word' : a:key, 'kind' : 'command',
      \       'action__command' : a:value,
      \  }
endfunction

"}}}

" ============== quickrun setting ==================== {{{2
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
        \ 'type' : 'markdown/pandoc',
        \ 'cmdopt' : '-s',
        \ 'outputter' : 'browser'
        \ }

"}}}

" ============== vimfiler setting ==================== {{{2
let g:vimfiler_as_default_explorer = 1
call vimfiler#set_execute_file('html', 'firefox')

"}}}

" ============== vim-watchdogs setting ==================== {{{2
let g:watchdogs_check_BufWritePost_enable = 1

let g:quickrun_config = {
      \ "watchdogs_checker/_" : {
      \     "hook/close_quickfix/enable_exit" : 1,
      \ },
      \ "cpp/watchdogs_checker" : {
      \     "hook/add_include_option/enable" : 1,
      \     "type" : "watchdogs_checker/clang++",
      \ },
      \ "watchdogs_checker/clang++" : {
      \     "command"   : "clang++",
      \     "exec" : "%c %o --std=c++1y -I ./ -Wall -fsyntax-only %s:p ",
      \},
\}

call watchdogs#setup(g:quickrun_config)
"}}}

" ============== project setting ==================== {{{2

" Project window size
let g:proj_window_width = 40
let g:proj_flags="bimst"
"}}}

" ============== deoplete clang ==================== {{{2
if has('mac')
  let g:deoplete#sources#clang#libclang_path="/Applications/Xcode.app/COntents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib"
  let g:deoplete#sources#clang#clang_header="/Applications/Xcode.app/COntents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang"
endif
if has('unix')
  let g:deoplete#sources#clang#libclang_path="/usr/lib/llvm-3.8/lib/libclang.so.1"
  let g:deoplete#sources#clang#clang_header="/usr/include/clang"
endif
"}}}

"}}}


"-------------------------------------------------------------
" Function and Command Defined {{{1
"-------------------------------------------------------------

" ======================= Dein command ==================== {{{2
command! DeinInstall :call dein#install()
command! DeinCheck :call dein#install()
"}}}

" ======================= Scouter ==================== {{{2
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction

command! -bar -bang -nargs=? -complete=file Scouter
\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)

"}}}

" ===================== ReloadVimrc ================== {{{2
command! ReloadVimrc source $MYVIMRC

"}}}

" ============ change encode by reload =============== {{{2
command! -bang -nargs=? Utf8
            \ edit<bang> ++enc=utf-8 <args>
command! -bang -nargs=? EucJP
            \ edit<bang> ++enc=euc-jp <args>

"}}}

" ================= ColorScheme Changer ============== {{{2
" 
let ColorRoller = {}
let ColorRoller.colorList = [
        \ 'jellybeans',
        \ 'molokai', 
        \ 'desert',
        \ 'darkblue',
        \ 'breeze',
        \ ]

function! ColorRoller.change()
  let item = get(self.colorList, 0)
  " tabpagecolorscheme の場合、"colorscheme" -> "Tcolorscheme" 
  silent exe "colorscheme " . item 
  redraw
  echo self.colorList
endfunction

function! ColorRoller.roll()
  let item = remove(self.colorList, 0)
  call insert(self.colorList, item, len(self.colorList))
  call self.change()
endfunction

function! ColorRoller.unroll()
  let item = remove(self.colorList, -1)
  call insert(self.colorList, item, 0)
  call self.change()
endfunction

"}}}

" ================ Dictional Search ================== {{{2
function! DictionalSearch()
  let l:str = expand("<cword>")
  let l:result = 0
  :redir => l:result
  execute ":!~/dict.py" l:str
endfunction

"}}}

" ================ Diff File ================== {{{2
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"}}}

" ================ quickfix clear ================ {{{2
function! QuickFixClear()
  :call setqflist([])
  :HierClear
endfunction
"}}}

" ================ All HighlightClear ================ {{{2
function! AllHighlightClear()
  call QuickFixClear()
  " search register clearing
  let @/ = ''
endfunction
"}}}

"}}}


"-------------------------------------------------------------
" Key Mapping {{{1
"-------------------------------------------------------------

" ============== buffer move setting ==================== {{{2
map <C-n>           :bnext<Return>
map <C-p>           :bprev<Return>

"}}}

" ============== check marks and registers setting ==================== {{{2
nnoremap <Space>m   :<C-u>marks<Return>
nnoremap <Space>r   :<C-u>registers<Return>
"}}}

" ============== help setting ==================== {{{2
nnoremap <C-h>     :<C-u>help<Space>
"}}}

" ============== tab Keybind setting ==================== {{{2
nnoremap <C-t>  <Nop>
nnoremap <C-t>n :<C-u>tabnew<Return>
nnoremap <C-t>c :<C-u>tabclose<Return>
nnoremap <C-t>j :<C-u>tabnext<Return>
nnoremap <C-t>k :<C-u>tabprev<Return>
"}}}

" ============== tags-and-searches setting ==================== {{{2
nnoremap t <Nop>
nnoremap tt <C-]>
nnoremap tj :<C-u>tag<Return>
nnoremap tk :<C-u>pop<Return>
nnoremap tl :<C-u>tags<Return>
nnoremap tn :<C-u>tnext<Return>
nnoremap tp :<C-u>tprevious<Return>
"}}}

" ============== Taglist.vim setting setting ==================== {{{2
nnoremap <Leader>t  :<C-u>Tlist<Return>
"}}}

" ============== QuickFix Keymapping setting ==================== {{{2
nnoremap Q q
nnoremap q <nop>
nnoremap ql :<C-u>clist<Return>
nnoremap qj :<C-u>cn<Return>
nnoremap qk :<C-u>cp<Return>
nnoremap qJ :<C-u>cfirst<Return>
nnoremap qK :<C-u>clast<Return>
nnoremap qo :<C-u>copen<Return>
nnoremap qc :<C-u>cclose<Return>
"}}}

" ============== QuickRun setting setting ==================== {{{2
nnoremap <Space>q :<C-u>QuickRun<Return>
"}}}

" ============== copy and paste for clipborad setting ==================== {{{2
noremap ,cp "*p
noremap ,cP "*P
noremap ,cy "*y
noremap ,cY "*Y
"}}}

" ============== colorschme change setting ==================== {{{2
nnoremap <silent><F2>   :<C-u>call ColorRoller.roll()<Return>
nnoremap <silent><F3>   :<C-u>call ColorRoller.unroll()<Return>
"}}}

" ============== 辞書を引く setting ==================== {{{2
nnoremap <Space>ds :<C-u>call DictionalSearch()<Return>
"}}}

" ============== cscope setting ==================== {{{2
nnoremap <Leader>cc :<C-u>cscope find c <C-R><C-W><Return>
nnoremap <Leader>cd :<C-u>cscope find d <C-R><C-W><Return>
nnoremap <Leader>ce :<C-u>cscope find e
nnoremap <Leader>cf :<C-u>cscope find f <C-R><C-W><Return>
nnoremap <Leader>ci :<C-u>cscope find i <C-R><C-P><Return>
nnoremap <Leader>cg :<C-u>cscope find g <C-R><C-W><Return>
nnoremap <Leader>cs :<C-u>cscope find s <C-R><C-W><Return>
"}}}

" ============== 関数移動 ==================== {{{2
" "]" , "[" の動作は行頭に "}", "{" が無いと適切に動作しないので、
" 行頭でなくても動作するように変更する. 
" "See :help [["
:map [[ ?{<CR>w99[{
:map ][ /}<CR>b99]}
:map ]] j0[[%/{<CR>
:map [] k$][%?}<CR>
"}}}

" ============== project setting ==================== {{{2
nmap <silent> <Space><Space> <Plug>ToggleProject
"}}}

" ============== unite setting ==================== {{{2
nmap <leader>f [unite]
nnoremap [unite]m   :<C-u>Unite menu<CR>
"}}}

" ============== terminal setting ==================== {{{2
nnoremap <Space>to :<C-u>Topen<return>
nnoremap <Space>tc :<C-u>Tclose<return>
"}}}

inoremap <C-U> <C-G>u<C-U>

"}}}


"-------------------------------------------------------------
" Editor Setting {{{1 
"-------------------------------------------------------------
:colorscheme jellybeans

set history=50		" keep 50 lines of command line history
set showcmd		" display incomplete commands

set number
set ruler		" show the cursor position all the time
set incsearch		" do incremental searching

"set encoding=utf-8
set expandtab
set shiftwidth=4
set tabstop=4
set wildmode=list:longest
set nocp
set cinoptions=g0
set hidden
set list

" cscope setting
set cscopetag
set cscopetagorder=1
set cscopequickfix=s-,c-,d-,i-,t-,e-

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

" 高さを40以上に設定する
" 幅を40以上に設定する
"set wh=40
"set wiw=90

" ============== Search Setting setting ==================== {{{2
set incsearch
set ignorecase
set smartcase
"}}}

" ============== filetype setting ==================== {{{2
au BufRead,BufNewFile *.cxx set filetype=cpp
"}}}

source $VIMRUNTIME/macros/matchit.vim

"}}}

" vim: set ts=2 sw=2 : 
" vim: set fdm=marker : 

