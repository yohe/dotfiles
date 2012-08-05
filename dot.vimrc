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

if has('mouse')
  set mouse=a
endif

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" backup
set backup
set backupdir=~/.vim/vim_backup
set swapfile
set directory=~/.vim/vim_swap

syntax enable
set ttymouse=xterm

" set statusline
set laststatus=2
set statusline=%<%f%y\ %h%m%r%=%-14.(%l,%c%V%)\ %P

set listchars=tab:>.,trail:-,eol:$,nbsp:%

" gui setting reload
if has('gui_macvim')
    source $MYGVIMRC
endif

" インクリメントのフォーマットを10進固定にする
" set nrformats=octal,hex (デフォルト設定) etc: alpha
set nrformats=

set modeline
set modelines=5

"}}}


"-------------------------------------------------------------
" Plugin Setting {{{1
"-------------------------------------------------------------

" ==================== vundle setting ================ {{{2
"set nocompatible;
filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'surround.vim'
Bundle 'textobj-user'
Bundle 'textobj-function'
Bundle 'textobj-fold'
"Bundle 'kana/vim-smartinput'
Bundle 'Shougo/unite.vim'
Bundle 'unite-colorscheme'
Bundle 'h1mesuke/unite-outline'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neocomplcache-snippets-complete'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/vimshell'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vinarise'
Bundle 'project.tar.gz'
Bundle 'quickrun.vim'
Bundle 'quickhl.vim'
Bundle 'taglist.vim'
Bundle 'open-browser.vim'
Bundle 'OmniCppComplete'
Bundle 'thinca/vim-ref'
Bundle 'mojako/ref-sources.vim'
Bundle 'vimwiki'
Bundle 'fuenor/qfixhowm'
Bundle 'taku-o/vim-toggle'
Bundle 'Color-Sampler-Pack'
Bundle 'hier'
Bundle 'learn-vimscript'
Bundle 'vim-jp/vital.vim'
Bundle 'increment.vim'
"Bundle 'Lokaltog/vim-powerline'

filetype plugin on
filetype plugin indent on
"}}}
"==================================================================
" プラグインの設定はこれ以降に記載する
"==================================================================


" =============== NeoCompleteCache Setting =========== {{{2
:let g:neocomplcache_enable_at_startup = 1
:let g:neocomplcache_min_syntax_length = 3
" キー入力時に保管を行う入力数
"let g:neocomplcache_auto_completion_start_length = 4
"let g:neocomplcache_manual_completion_start_length = 4

" 補完候補の中から共通部分を保管
inoremap <expr><C-Space>    neocomplcache#complete_common_string()
inoremap <expr><C-j>        neocomplcache#complete_common_string()

" 文字削除時にポップアップを削除する
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

" 選択している候補の確定
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" 選択している候補のキャンセル
inoremap <expr><C-e> neocomplcache#cancel_popup()

" Enable omni completion
"autocmd FileType c setlocal omnifunc=ccomplete#Complete
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Examples:
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
:let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
:let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
:let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
:let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'


"}}}

" ================ colorscheme ======================= {{{2
let g:molokai_original = 1

"}}}

" ============== vimproc Setting ==================== {{{2
"}}}

" ============== VimShell Setting ==================== {{{2
let g:vimshell_split_command = ""
"let g:vimshell_no_default_keymappings = 1
inoremap <C-w><C-w> <ESC><C-w>w
inoremap <C-w>j <ESC><C-w>j
inoremap <C-w>k <ESC><C-w>k
inoremap <C-w>l <ESC><C-w>l
inoremap <C-w>h <ESC><C-w>h

let g:vimshell_user_prompt = 'getcwd()'
"let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
let g:vimshell_prompt = $USER." $ "

"}}}

" ================== VimWiki setting ================= {{{2

" VimWiki設定
let wiki_1 = {}
let wiki_1.path = '~/.howm/Wiki/'
let wiki_1.path_html = '~/vimwiki_html/'

let g:vimwiki_list = [wiki_1]
let g:vimwiki_folding = 1

"}}}

" ============== vimwiki calender ==================== {{{2
let g:vimwiki_use_calendar=1

"}}}

" ============== QFixHowm setting ==================== {{{2
" デフォルトのhowmバッファ以外を使用する
"let QFixHowm_HowmMode = 0

" ディレクトリ設定
let howm_dir = '~/.howm'
let QFixHowm_TagsDir = howm_dir

let QFixHowm_OpenURICcmd = '!open %s'

" オートリンクでファイルを開く, and TagJampFile Create
let QFixHowm_Wiki = 1
let QFixHowm_UseAutLinkTags = 1

let QFixHowm_ShowSchedule = 15
let QFixHowm_ShowScheduleTodo = 7
" 予定にリマインダも表示
let QFixHowm_ListReminder_ScheExt = '[-@!.]'

"一日一回　予定自動表示
let QFixHowm_VimEnterCmd = 'y'
let QFixHowm_VimEnterMsg = '今日の予定を表示します'
let QFixHowm_Wiki = 1

let QFixHowm_DiaryFile = '~/.howm/Wiki/diary/%Y-%m-%d.wiki'

"新規エントリのテンプレート
let QFixHowm_Template = [
  \"= %TITLE% %TAG%",
  \""
\]

" Howm2Html setting {{{3
" ディレクトリ設定
let HowmHtml_basedir = howm_dir
let HowmHtml_htmldir = '~/.howm_html'
let HowmHtml_publish_htmldir = '~/.howm_html'
let HowmHtml_RelPath = HowmHtml_htmldir
let HowmHtml_publish_RelPath = HowmHtml_publish_htmldir

" Page Setting
let QFixHowm_Title = '='
let HowmHtml_Bullet = ' § '
let HowmHtml_DefaultName = 'howm2html.html'
let HowmHtml_ConvertLevel = 2
let HowmHtml_suffix = 'html'
let HowmHtml_suffix_mode = ':t:r'
let HowmHtml_encoding = 'utf-8'
let HowmHtml_cssname = 'vicuna.css'
let HowmHtml_Vicuna = 'eye-h double-l'
let HowmHtml_SightName = "Yohei Sekigchi"
let HowmHtml_Description = 'ローカルブログ'

"サイドバー
let HowmHtml_Entries = [
  \ '<dt>リンク</dt><dd><ul>',
  \ '<li><a href="%BASEDIR%/howm2html.html" title="HOME">ホーム</a></li>',
  \ '<ul></dd>',
  \ '<dt>Entries</dt><dd><ul>',
\]

let g:HowmHtml_Others = [
  \ '<dt>過去ログ</dt><dd><ul>',
  \ '<li><a href="%BASEDIR%/archives/2010.html" title="2010">2010</a></li>',
  \ '</ul></dd>',
\]

"}}}

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

" ============== OmniCppComplete setting ==================== {{{2
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

"}}}

" ============== hier.vim setting ==================== {{{2
let g:hier_highlight_group_qf   = 'SpellBad'
let g:hier_highlight_group_qfw  = 'SpellLocal'
let g:hier_highlight_group_qfi  = 'SpellRare'

"}}}

" ============== vim-ref setting ==================== {{{2

"}}}

" ============== increment.vim setting ==================== {{{2
let g:increment_vim = {}
let g:increment_vim = { 'vim':["let", "function", "endfunction", "if", "else", "elseif", "endif"], 
      \                 'cpp':["class", "struct", "public", "protected", "private", "if", "else", "==", "!=", "<=", ">=", ">", "<"], 
      \ }
"}}}

"}}}



" Function and Command Defined {{{1
"-------------------------------------------------------------

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
nnoremap <C-h>      :<C-u>help<Space>
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

" ============== copy and paste for clipborad setting ==================== {{{2
noremap ,cp "*p
noremap ,cP "*P
noremap ,cy "*y
noremap ,cY "*Y
"}}}

" ============== NeoCompleteCache Keybind setting ==================== {{{2
imap <C-l>    <Plug>(neocomplcache_snippets_expand)
smap <C-l>    <Plug>(neocomplcache_snippets_expand)
"}}}

" ============== quickhl.vim Keybind setting ==================== {{{2
nmap <Space>h <Plug>(quickhl-toggle)
xmap <Space>h <Plug>(quickhl-toggle)
nmap <Space>H <Plug>(quickhl-reset)
xmap <Space>H <Plug>(quickhl-reset)
nmap <Space>j <Plug>(quickhl-match)
"}}}

" ============== highlighting Clear setting ==================== {{{2
nmap <silent><ESC><ESC> :<C-u>call AllHighlightClear()<Return>
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

" ============== Taglist.vim setting setting ==================== {{{2
nnoremap <Leader>t  :<C-u>Tlist<Return>
"}}}

" ============== colorschme change setting ==================== {{{2
nnoremap <silent><F2>   :<C-u>call ColorRoller.roll()<Return>
nnoremap <silent><F3>   :<C-u>call ColorRoller.unroll()<Return>
"}}}

" ============== QuickRun setting setting ==================== {{{2
nnoremap <Space>q :<C-u>QuickRun<Return>
"}}}

" ============== 辞書を引く setting ==================== {{{2
nnoremap <Space>ds :<C-u>call DictionalSearch()<Return>
"}}}

" ============== improved increment  setting ==================== {{{2
nnoremap <silent> <C-a> :<C-u>NextPattern<Return>
nnoremap <silent> <C-x> :<C-u>PrevPattern<Return>
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

" "]" , "[" の動作は行頭に "}", "{" が無いと適切に動作しないので、
" 行頭でなくても動作するように変更する. 
" "See :help [["
:map [[ ?{<CR>w99[{
:map ][ /}<CR>b99]}
:map ]] j0[[%/{<CR>
:map [] k$][%?}<CR>

map Q gq

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
set wh=40
set wiw=90

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

