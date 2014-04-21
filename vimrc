" +++++++++++++++++++
" open all folds  zR
" close all folds  zM
" @see :h fold
" +++++++++++++++++++

" {{{ 基本的な設定
"----------------------------------------------------
"leader
let mapleader=" "
"vimでbackspaceが効かないときの設定
noremap  
noremap!  
"256色に対応
set t_Co=256
"Swapディレクトリを指定する場合
":set directory=~/.vim/vim_swp
"viと同期しない設定
set nocompatible
"改行の認識
set fileformats=unix,dos,mac
"音を消す
set vb t_vb=
" バッファを切替えてもundoの効力を失わない
set hidden
" 起動時のメッセージを表示しない
set shortmess+=I

" バックスペースキーで削除できるものを指定
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

" high light current line
au WinLeave * set nocursorline
au WinEnter * set cursorline
set cursorline "cursorcolumn
" }}}


" {{{ バックアップ関係
"----------------------------------------------------
" バックアップをとらない
set nobackup
" ファイルの上書きの前にバックアップを作る
" (ただし、backup がオンでない限り、バックアップは上書きに成功した後削除される)
set writebackup

" バックアップをとる場合
"set backup
" バックアップファイルを作るディレクトリ
"set backupdir=~/backup
" }}}


" {{{ 検索関係
"----------------------------------------------------
" コマンド、検索パターンを100個まで履歴に残す
set history=100
" 検索の時に大文字小文字を区別しない
set ignorecase
" 検索の時に大文字が含まれている場合は区別して検索する
set smartcase
" 最後まで検索したら先頭に戻る
set wrapscan
" インクリメンタルサーチを使わない
set noincsearch
" Ruby jump do - end
source $VIMRUNTIME/macros/matchit.vim
" }}}


" {{{ 表示関係
"----------------------------------------------------
" タイトルをウインドウ枠に表示する
set title
" ルーラーを表示
set ruler number
set number
" タブ文字を CTRL-I で表示し、行末に $ で表示する
set list
" 入力中のコマンドをステータスに表示する
set showcmd
" ステータスラインを常に表示
set laststatus=2
" 括弧入力時の対応する括弧を表示
set showmatch
" 対応する括弧の表示時間を2にする
set matchtime=2
" シンタックスハイライトを有効にする
syntax on
" 検索結果文字列のハイライトを有効にする
"set hlsearch
" コメント文の色を変更
highlight Comment ctermfg=DarkCyan
" コマンドライン補完を拡張モードにする
set wildmenu

" 入力されているテキストの最大幅
" (行がそれより長くなると、この幅を超えないように空白の後で改行される)を無効にする
set textwidth=0
" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

colorscheme Tomorrow-Night-Bright-Simeji
" solarizedを使う場合
"syntax enable
"set background=dark
"colorscheme solarized

" ステータスラインに表示する情報の指定
"set statusline=%n\:%y%F\ \|%{fugitive#statusline()}%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=
"set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=
" ステータスラインの色
"highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none
"highlight statusline   term=NONE cterm=NONE guifg=red ctermfg=yellow ctermbg=red
" }}}


" {{{ インデント
"----------------------------------------------------
" オートインデントを有効にする
set autoindent
" タブが対応する空白の数
set tabstop=2
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=2
" インデントの各段階に使われる空白の数
set shiftwidth=2
" タブを挿入するとき、代わりに空白を使わない
"set noexpandtab
" タブにスペースを使う
set expandtab
" }}}


" {{{ 文字コード関係
"----------------------------------------------------
" 文字コードの設定
" fileencodingsの設定ではencodingの値を一番最後に記述する
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,euc-jp,cp932,iso-2022-jp
set fileencodings+=,ucs-2le,ucs-2,utf-8

if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
        let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
        let &fileencodings = &fileencodings .','. s:fileencodings_default
        unlet s:fileencodings_default
    else
        let &fileencodings = &fileencodings .','. s:enc_jis
        set fileencodings+=utf-8,ucs-2le,ucs-2
        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
            set fileencodings+=cp932
            set fileencodings-=euc-jp
            set fileencodings-=euc-jisx0213
            set fileencodings-=eucjp-ms
            let &encoding = s:enc_euc
            let &fileencoding = s:enc_euc
        else
            let &fileencodings = &fileencodings .','. s:enc_euc
        endif
    endif
    unlet s:enc_euc
    unlet s:enc_jis
endif
if has('autocmd')
   function! AU_ReCheck_FENC()
       if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
          let &fileencoding=&encoding
       endif
   endfunction
   autocmd BufReadPost * call AU_ReCheck_FENC()
endif
set fileformats=unix,dos,mac
if exists('&ambiwidth')
    set ambiwidth=double
endif

"svnの時はutf-8に文字コードを設定
autocmd FileType svn :set fileencoding=utf-8
" }}}


" {{{ ctags
"----------------------------------------------------
" 同じ関数名があった場合、どれに飛ぶか選択できるようにする
nnoremap <C-]> g<C-]>

"taglist
let Tlist_Ctags_Cmd = "/usr/bin/ctags"    "ctagsのパス
let Tlist_Show_One_File = 1               "現在編集中のソースのタグしか表示しない
let Tlist_Exit_OnlyWindow = 1             "taglistのウィンドーが最後のウィンドーならばVimを閉じる
let Tlist_Use_Right_Window = 1            "taglistを右側で開く
" }}}


" {{{ タブの移動
"----------------------------------------------------
inoremap <buffer> <TAB> <C-n>
inoremap <buffer> <S-TAB> <C-p>
" }}}


" {{{ オートコマンド
"----------------------------------------------------
if has("autocmd")
    " ファイルタイプ別インデント、プラグインを有効にする
    filetype plugin indent on
    " カーソル位置を記憶する
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
endif
" }}}


"" {{{ <TAB>で補完
"----------------------------------------------------
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<TAB>"
    else
        if pumvisible()
            return "\<C-N>"
        else
            return "\<C-N>\<C-P>"
        end
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"}}}


" {{{ Syntax関係
"----------------------------------------------------

"smarty シンタックスの設定
au BufRead,BufNewFile *.tpl.* set filetype=smarty
au Filetype smarty exec('set dictionary=$HOME/.vim/syntax/smarty.vim')
au Filetype smarty set complete+=k

"rspec シンタックスの設定
au BufRead,BufNewFile *_spec.rb set filetype=ruby.rspec
au Filetype ruby exec('set dictionary=$HOME/.vim/syntax/rspec.vim')

"jstest シンタックスの設定
au BufRead,BufNewFile *_spec.js set filetype=javascript.jstest

"ejs シンタックスの設定
au BufRead,BufNewFile *.ejs set filetype=jst
let g:NERDCustomDelimiters = {'jst': { 'left': '<!-- ', 'right': ' -->' }}
" }}}


" {{{ キーマップ割り当て
"----------------------------------------------------
nnoremap <C-n> gt
nnoremap <C-p> gT

if v:version >= 700
    nnoremap <C-g> :call OpenNewTab()<CR>
    function! OpenNewTab()
        let f = expand("%:p")
        execute ":q"
        execute ":tabnew ".f
    endfunction
endif

nnoremap <Space>s. :<C-u>source $HOME/.vimrc<CR>
" }}}


" {{{ VCSDiff拡張 VCSDiffPast
"-----------------------------------------------
"svnでいくつ前のリビジョンかを指定して比較を行なう
"listオプションを指定すれば一覧から選択形式で比較できる
"
"※HEADリビジョンを1としている
"
">>>>>>>>>>>>>>>>>> 使い方 <<<<<<<<<<<<<<<<<
"
"調べたいファイルをアクティブにして
"コマンドモードで下記コマンドを実行する
"
":VCSDiffPast [-list] number
"# [-list] はオプション(省略可)
"# VCSDiff形式で比較
"# number はHEADリビジョンを1としている
"
":VCSVimDiffPast [-list] number
"# [-list] は一覧表示オプション(省略可)
"# VCSVimDiff形式で比較
"# number はHEADリビジョンを1としている
"
"
">>>>>>>>>>>>>>>>>>> 例 <<<<<<<<<<<<<<<<<<<<
"
":VCSDiffPast 1
"#最新バージョンのソースとVCSDiffで比較
"#普通のVCSDiffと同じ
"
":VCSDiffPast 2
"#最新バージョン前のバージョンのソースとVCSDiffで比較
"
":VCSDiffPast -list 20
"#過去、20バージョンのリビジョン番号とコミッタ、日時を
"#リスト形式で表示して、選択されたものと差異をVCSDiffで比較
"
":VCSVimDiffPast 1
"#最新バージョンのソースとVCSVimDiffで比較
"#普通のVCSVimDiffと同じ
"
":VCSVimDiffPast 3
"#最新バージョン前の前のソースとVCSVimDiffで比較
"
":VCSVimDiffPast -list 15
"#過去、15バージョンのリビジョン番号とコミッタ、日時を
"#リスト形式で表示して、選択したものとの差異をVCSDiffで比較
"
"-----------------------------------------------
com! -nargs=* VCSDiffPast call VCSDiffPast(<f-args>)
com! -nargs=* VCSVimDiffPast call VCSVimDiffPast(<f-args>)

function! VCSDiffPast(n,...)
    if a:0 > 0 && a:n == "-list"
        let rev = GetPastRevisionByList(a:1)
    else
        let rev = GetPastRevision(a:n)
    endif
    execute ":VCSDiff ".rev
endfunction

function! VCSVimDiffPast(n,...)
    if a:0 > 0 && a:n == "-list"
        let rev = GetPastRevisionByList(a:1)
    else
        let rev = GetPastRevision(a:n)
    endif
    execute ":VCSVimDiff ".rev
endfunction

function! GetPastRevision(n)
    let f = expand("%:p")
    let rev = system("svn log -q --limit ".a:n." ".f." |awk '$2{print $1}' | awk -v ORS='' 'NR==".a:n."{print $1}'")
    return rev
endfunction

function! GetPastRevisionByList(n)
    let f = expand("%:p")
    let num = a:n < 1 ? 10 : a:n
    let rev = system("svn log -q --limit ".num." ".f." |awk '$2{print $1 \" \" $3 \" \" $5}' | awk -v ORS=',' '{print NR-1\": \"$1\" \"$2\" \"$3}'")
    let lines = split(rev,',')
    let choice = inputlist(lines)
    if choice >= 0 && choice < len(lines)
        let r = split(lines[choice],' ')[1]
    else
        echo "どれかを選択してください"
        let r = 0
    endif
    return r
endfunction
" }}}


" {{{ 範囲移動
"---------------------------------------------------
vnoremap <C-K> :m -2<CR>v '<
vnoremap <C-J> :m '>+1<CR>v '<
" }}}


" {{{ タブに{tabNo} - {window count}を表示する
"---------------------------------------------------
if v:version >= 700

    function! TabLine()
        let res = ''
        let curtab = tabpagenr()
        let i = 1
        for i in range(1, tabpagenr('$'))
            let res .= ((i == curtab) ? '%#TabLineSel#' : '%#TabLine#')
            let res .= i . '-' . tabpagewinnr(i, '$') . ':'
            let res .= substitute(bufname(tabpagebuflist(i)[0]), '.\+\/', '', 'g')
            let res .= ' '
            let i += 1
            exe | endfor
        let res .= '%#TabLineFill#'
        return res
    endfunction

    set tabline=%!TabLine()

endif
" }}}


" {{{ NeoBundle Setting
"---------------------------------------------------
if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" }}}


" {{{ !!! VIM PLUGINS  !!! (managed by NeoBundle)
"---------------------------------------------------
NeoBundle 'unite-gem'
NeoBundle 'unite-locate'
NeoBundle 'unite-font'
NeoBundle 'unite-colorscheme'
NeoBundle 'pasela/unite-webcolorname.git'
NeoBundle 'surround.vim'
NeoBundle 'vcscommand.vim'
NeoBundle 'jimsei/winresizer'
NeoBundle 'scrooloose/nerdcommenter.git'
NeoBundle 'scrooloose/nerdtree.git'
NeoBundle 'pangloss/vim-javascript.git'
NeoBundle 'thinca/vim-quickrun.git'
NeoBundle 'briancollins/vim-jst.git'
"NeoBundleLazy 'Shougo/unite-session'
NeoBundle 'bling/vim-airline'
NeoBundleLazy 'Shougo/unite-outline'
NeoBundleLazy 'osyo-manga/vim-reanimate', {
      \ 'autoload' : {
      \ 'commands' : ['ReanimateLoad', 'ReanimateSave' ]
      \ }}
NeoBundle 'thinca/vim-ref', {
      \ 'commands' : 'Ref',
      \ 'unite_sources' : 'ref',
      \ }
NeoBundleLazy 'thinca/vim-unite-history', {
      \ 'unite_sources' : ['history/command', 'history/search']
      \ }
NeoBundleLazy 'Shougo/neosnippet.vim', {
      \ 'depends' : ['Shougo/neosnippet-snippets'],
      \ 'insert' : 1,
      \ 'filetypes' : 'snippet',
      \ 'unite_sources' : [
      \ 'neosnippet', 'neosnippet/user', 'neosnippet/runtime'],
      \ }
NeoBundleLazy 'vim-jp/vital.vim', {
      \ 'commands' : 'Vitalize',
      \ }
NeoBundleLazy 'Shougo/junkfile.vim', {
      \ 'commands' : 'JunkfileOpen',
      \ 'unite_sources' : ['junkfile', 'junkfile/new'],
      \ }

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundleLazy 'Shougo/unite.vim', {
      \ 'commands' : [{ 'name' : 'Unite',
      \ 'complete' : 'customlist,unite#complete_source'},
      \ 'UniteWithCursorWord', 'UniteWithInput']
      \ }
NeoBundleLazy 'Shougo/unite-build'
NeoBundleLazy 'Shougo/unite-ssh', {
      \ 'filetypes' : 'vimfiler',
      \ }

NeoBundleLazy 'ujihisa/vimshell-ssh', {
      \ 'filetypes' : 'vimshell',
      \ }

NeoBundleLazy 'Shougo/vimshell.vim', {
      \ 'commands' : [{ 'name' : 'VimShell',
      \ 'complete' : 'customlist,vimshell#complete'},
      \ 'VimShellExecute', 'VimShellInteractive',
      \ 'VimShellCreate',
      \ 'VimShellTerminal', 'VimShellPop'],
      \ 'mappings' : '<Plug>(vimshell_'
      \ }
NeoBundle 'kana/vim-operator-user', {
      \ 'functions' : 'operator#user#define',
      \ }
NeoBundleLazy 'kana/vim-operator-replace', {
      \ 'depends' : 'vim-operator-user',
      \ 'autoload' : {
      \ 'mappings' : [
      \ ['nx', '<Plug>(operator-replace)']]
      \ }}
NeoBundleLazy 'kana/vim-textobj-user'
NeoBundle 'altercation/vim-colors-solarized'

function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

if s:meet_neocomplete_requirements()
    NeoBundleLazy 'Shougo/neocomplete.vim', {
        \ 'depends' : 'Shougo/context_filetype.vim',
        \ 'insert' : 1
        \ }
    NeoBundleFetch 'Shougo/neocomplcache.vim'
else
    NeoBundleFetch 'Shougo/neocomplete.vim'
    NeoBundle 'Shougo/neocomplcache.vim', {
         \ 'insert' : 1
         \ }
endif

"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'scrooloose/syntastic.git'
"NeoBundle 'rails.vim'
filetype plugin indent on
" }}}


" {{{ Vim plugin settings
"---------------------------------------------------
"
" {{{ Unite Setting
"---------------------------------------------------
let g:unite_enable_start_insert = 1
let g:unite_enable_split_vertically = 1
"unite keymap prefix
nnoremap [unite] <Nop>
nmap <Space>u [unite]
"register list
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register -default-action=yank<CR>
"mru list
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
"buffer list
nnoremap <silent> [unite]b :<C-u>Unite buffer -default-action=vsplit<CR>
"unite outline
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
"unite bookmark add
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"unite bookmark list
nnoremap <silent> [unite]l :<C-u>Unite bookmark<CR>
autocmd FileType * nnoremap <silent><buffer> [unite]t :<C-u>Unite -default-action=vsplit ref/man<CR>
autocmd FileType erlang nnoremap <silent><buffer> [unite]t :<C-u>Unite -default-action=vsplit ref/erlang<CR>
autocmd FileType ruby nnoremap <silent><buffer> [unite]t :<C-u>Unite -default-action=vsplit ref/refe<CR>
autocmd FileType python nnoremap <silent><buffer> [unite]t :<C-u>Unite -default-action=vsplit ref/pydoc<CR>
autocmd FileType perl nnoremap <silent><buffer> [unite]t :<C-u>Unite -default-action=vsplit ref/perldoc<CR>
" }}}

" {{{ neocomplcache or neocomplete setting
"---------------------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

if s:meet_neocomplete_requirements()
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
          \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
  "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
  "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
  "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
  " Or set this.
  "let g:neocomplete#enable_cursor_hold_i = 1
  " Or set this.
  "let g:neocomplete#enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  "let g:neocomplete#enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplete#enable_auto_select = 1
  "let g:neocomplete#disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
else
  " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Use camel case completion.
  let g:neocomplcache_enable_camel_case_completion = 1
  " Use underbar completion.
  let g:neocomplcache_enable_underbar_completion = 1
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
" Plugin key-mappings.
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
  "SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: "\<TAB>"

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif

  inoremap <expr><C-g>     neocomplcache#undo_completion()
  inoremap <expr><C-l>     neocomplcache#complete_common_string()

  " Unite Snip
  imap <C-s>  <Plug>(neosnippet_start_unite_snippet)

  " SuperTab like snippets behavior.
  "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup()

  " AutoComplPop like behavior.
  "let g:neocomplcache_enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplcache_enable_auto_select = 1
  "let g:neocomplcache_disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
  "inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  "let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
  let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

  " plugin rank
  if !exists('g:neocomplcache_plugin_rank')
    let g:neocomplcache_plugin_rank = {}
  endif
  let g:neocomplcache_plugin_rank.buffer_complete = 90
endif
" }}}

" {{{ winresizer
"----------------------------------------------------
let g:winresizer_enable = 1
let g:winresizer_start_key = '<C-E>'
" }}}


" {{{ quickrun
"----------------------------------------------------
let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc', "runner/vimproc/updatetime" : 10}
let g:quickrun_config['ruby.rspec'] = {'command': 'rspec', 'cmdopt': '-cfs'}
let g:quickrun_config['javascript.jstest'] = {'command': 'mocha' }

"let g:quickrun_config['*'] = {'runmode': 'async:remote:vimproc'}

augroup UjihisaRSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

nnoremap [quickrun] <Nop>
nmap <Space>k [quickrun]
nnoremap <silent> [quickrun]r :call QRunRspecCurrentLine()<CR>
fun! QRunRspecCurrentLine()
  let line = line(".")
  exe ":QuickRun -cmdopt '-cfs -l " . line . "'"
endfun
" }}}

" {{{ vim-ref
"----------------------------------------------------
let g:ref_use_vimproc = 1
let $GEM_HOME = $HOME . "/dotfiles/gems"
let g:ref_refe_cmd = $HOME . "/dotfiles/gems/bin/refe"
" }}}

" {{{ JunkFile.
"----------------------------------------------------
command! -nargs=0 JunkFile call s:open_junk_file()
function! s:open_junk_file()
  let l:junk_dir = $HOME . '/.vim_junk'. strftime('/%Y/%m')
  if !isdirectory(l:junk_dir)
    call mkdir(l:junk_dir, 'p')
  endif

  let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
  if l:filename != ''
    execute 'edit ' . l:filename
  endif
endfunction
" }}}

" {{{ vim-operator-replace
"----------------------------------------------------
"
nmap R <Plug>(operator-replace)
xmap R <Plug>(operator-replace)
" }}}

" vim-airline {{{
let s:bundle = neobundle#get("vim-airline")
let s:bundle.hooks = get(s:bundle, "hooks", {})
function! s:bundle.hooks.on_source(bundle)
  "let g:airline_section_b = "%{matchstr(reanimate#last_point(), '.*/\\zs.*')}"
  let g:airline_theme='solarized'
endfunction
unlet s:bundle
let g:airline_section_a = airline#section#create(['%<', 'file', 'readonly'])
let g:airline_section_b = airline#section#create_left(['mode', 'paste', 'iminsert'])
let g:airline_section_c = airline#section#create(['hunks'])
"let g:airline_section_gutter = airline#section#create(['%=%y%m%r[%{&ff}]'])
"let g:airline_section_x = airline#section#create_right(['filetype'])
let g:airline_section_y = '%y%m%r%=[%{&ff}]' "airline#section#create_right(['ffenc'])
"let g:airline_section_y = airline#section#create_right(['ffenc'])
let g:airline_section_z = airline#section#create(['%(%l,%c%V%) %P'])
let g:airline_section_warning = airline#section#create(['whitespace'])
"" }}}

"" {{{ NERDTree
""----------------------------------------------------
"let NERDTreeDirArrows=0

"nnoremap <F8> :NERDTreeFind<CR>
"nnoremap <silent> <F9> :NERDTreeToggle<CR>

"" }}}

" {{{ Syntastic setting for Javascript JSLint
"----------------------------------------------------
"let g:syntastic_javascript_jslint_conf="--maxerr=400 --indent=2 --undef --nomen --regexp --plusplus --bitwise --newcap --sloppy --vars"
"let g:syntastic_mode_map = {
"  \ 'mode': 'active',
"  \ 'active_filetypes': ['javascript', 'json'],
"  \ 'passive_filetypes': ['php'] }
" }}}

" {{{ 独自拡張を読み込む 独自拡張が優先させるため、このブロックは末尾に記載する事
"----------------------------------------------------

if glob("$HOME/.vimrc.local") != ''
  source $HOME/.vimrc.local
endif
" }}}

" }}}

" +++++++++++++++++++
" open all folds  zR
" close all folds  zM
" @see :h fold
" +++++++++++++++++++

" vim: foldmethod=marker:
