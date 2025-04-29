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

"go シンタックスの設定
au Filetype gohtmltmpl set filetype=html.gohtmltmpl
let g:NERDCustomDelimiters = {'gohtmltmpl': { 'left': '{{/* ', 'right': ' */}}' }}
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




" {{{ Vim plugin settings
"---------------------------------------------------
"
" {{{ denops.vim

let g:denops#deno = $HOME . '/.deno/bin/deno'
const s:denops_src = $HOME .'/.cache/dpp/repos/github.com/vim-denops/denops.vim/'
const s:denops_hello_src = $HOME .'/.cache/dpp/repos/github.com/vim-denops/denops-helloworld.vim/'
execute 'set runtimepath^=' .. s:denops_src
execute 'set runtimepath^=' .. s:denops_hello_src

" }}}

" {{{ dein.vim

set nocompatible

const s:dein_base = expand('~/.cache/dein')
const s:dein_repo = s:dein_base . '/repos/github.com/Shougo/dein.vim'
" runtimepath に追加（末尾のスラッシュを除去）
execute 'set runtimepath+=' .  fnamemodify(s:dein_repo, ':p')->substitute('[/\\]\\+$', '', '')


if dein#load_state(s:dein_base)
  " dein 初期化とプラグイン登録
  call dein#begin(s:dein_base)

  " ここに他プラグインを追加
  "call dein#add('author/plugin', { 'on_cmd': ['Cmd'] })
  "
  " dein.vim
  call dein#add('Shougo/dein.vim')
  " denops.vim （v7.0+ が必要）
  call dein#add('vim-denops/denops.vim')
  " dpp.vim 本体（Vim9.1.0448+ / Neovim0.10.0+ が必要）
  call dein#add('Shougo/dpp.vim')
  " リモートプラグイン導入用エクステンション
  call dein#add('Shougo/dpp-ext-installer', { 'on_cmd': ['DppInstallExt'] })
  " Language Server Protocol (vim-lsp)
  call dein#add('prabirshrestha/vim-lsp')
  " Automatic LSP server installer for vim-lsp
  call dein#add('mattn/vim-lsp-settings')
  " Surround text objects (parentheses, quotes, tags, etc.)
  call dein#add('tpope/vim-surround')
  " Easy window resizing with hjkl keys
  call dein#add('simeji/winresizer')
  " File system explorer
  call dein#add('scrooloose/nerdtree')
  " Fast-motion plugin
  call dein#add('Lokaltog/vim-easymotion')

  call dein#end()
  call dein#save_state()

endif

" 自動インストール
if dein#check_install()
  call dein#install()
endif
" Ex コマンド定義（任意）
"command! DppInstallExt call dpp#async_ext_action('installer', 'install')

" ファイルタイプ検出・インデント・シンタックス有効化
filetype plugin indent on
syntax enable
" }}}


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


" {{{ winresizer
"----------------------------------------------------
let g:winresizer_enable = 1
let g:winresizer_start_key = '<C-E>'
" }}}


" {{{ vim-lsp
"function! s:onLspBufferEnabled() abort
"  setlocal omnifunc=lsp#complete
"  setlocal signcolumn=yes
"  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"
"  nnoremap <buffer> gd <plug>(lsp-definition)
"  nnoremap <buffer> gs <plug>(lsp-document-symbol-search)
"  nnoremap <buffer> gS <plug>(lsp-workspace-symbol-search)
"  nnoremap <buffer> gr <plug>(lsp-references)
"  nnoremap <buffer> gi <plug>(lsp-implementation)
"  nnoremap <buffer> gt <plug>(lsp-type-definition)
"  nnoremap <buffer> gn <plug>(lsp-rename)
"  nnoremap <buffer> [g <plug>(lsp-previous-diagnostic)
"  nnoremap <buffer> ]g <plug>(lsp-next-diagnostic)
"  nnoremap <buffer> K <plug>(lsp-hover)
"  nnoremap <buffer> <C-l>d <Cmd>rightbelow LspDefinition<CR>
"
"  let g:lsp_format_sync_timeout = 1000
"endfunction
"
"augroup lsp_install
"  au!
"  autocmd User lsp_buffer_enabled call s:onLspBufferEnabled()
"augroup END
"
"" vim-lsp-settins
"let g:lsp_settings_filetype_javascript = ['typescript-language-server']
"let g:lsp_settings_filetype_javascriptreact = ['typescript-language-server']
"let g:lsp_settings_filetype_typescript = ['typescript-language-server']
"let g:lsp_settings_filetype_typescriptreact = ['typescript-language-server']
" }}}

" {{{ quickrun
"----------------------------------------------------
let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc', "runner/vimproc/updatetime" : 10}
let g:quickrun_config['ruby.rspec'] = {'command': 'rspec', 'cmdopt': '-cfs'}
let g:quickrun_config['go.gotest'] = {'command': 'go test', 'cmdopt': '-run'}
let g:quickrun_config['javascript.jstest'] = {'command': 'mocha' }

"let g:quickrun_config['*'] = {'runmode': 'async:remote:vimproc'}

augroup GroupRSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

augroup GroupGoTest
  autocmd!
  autocmd BufWinEnter,BufNewFile *_test.go set filetype=go.gotest
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

" {{{ vim-operator-replace
"----------------------------------------------------
"
nmap R <Plug>(operator-replace)
xmap R <Plug>(operator-replace)
" }}}

" vim-gitgutter {{{
"----------------------------------------------------
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'
" }}}

" lightline.vim {{{
"----------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['gitgutter', 'filename'],
      \   ],
      \   'right': [
      \     ['lineinfo', 'syntastic'],
      \     ['filetype'],
      \     ['fileformat', 'fileencoding'],
      \   ]
      \ },
      \ 'inactive': {
      \   'left': [['inactive_filename']],
      \   'right': [['filetype']]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'filename': 'MyFilename',
      \   'inactive_filename': 'MyInactiveFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'syntastic': 'SyntasticStatuslineFlag',
      \   'gitgutter': 'MyGitGutter',
      \ },
      \ 'separator': {'left': '｜', 'right': '｜'},
      \ 'subseparator': {'left': '｜', 'right': '｜'}
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '[RO]' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \ '' != expand('%:t') ? expand('%:p') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyInactiveFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'nerdtree' ? 'NERDTree' :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
"function! MyCharCode()
"if winwidth('.') <= 70
"return ''
"endif

"" Get the output of :ascii
"redir => ascii
"silent! ascii
"redir END

"if match(ascii, 'NUL') != -1
"return 'NUL'
"endif

"" Zero pad hex values
"let nrformat = '0x%02x'

"let encoding = (&fenc == '' ? &enc : &fenc)

"if encoding == 'utf-8'
"" Zero pad with 4 zeroes in unicode files
"let nrformat = '0x%04x'
"endif

"" Get the character and the numeric value from the return value of :ascii
"" This matches the two first pieces of the return value, e.g.
"" "<F>  70" => char: 'F', nr: '70'
"let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

"" Format the numeric value
"let nr = printf(nrformat, nr)

"return "'". char ."' ". nr
"endfunction
" }}}

"" {{{ NERDTree
""----------------------------------------------------
let NERDTreeDirArrows=0

nnoremap <F8> :NERDTreeFind<CR>
nnoremap <silent> <F9> :NERDTreeToggle<CR>

"" }}}

" {{{ vim-easymotion
"----------------------------------------------------
map <Leader> <Plug>(easymotion-prefix)
" smartcase
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_migemo = 1
nmap <Leader>/ <Plug>(easymotion-sn)
xmap <Leader>/ <Plug>(easymotion-sn)
omap <Leader>/ <Plug>(easymotion-tn)
" }}}

" {{{ vim-json
"----------------------------------------------------
let g:vim_json_syntax_conceal = 0

" }}}

" {{{ vim-go
"----------------------------------------------------
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" }}}

" {{{ vim-coffee-script
"----------------------------------------------------
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデント設定
autocmd FileType coffee   setlocal sw=2 sts=2 ts=2 et
"保存と同時にコンパイルする
autocmd BufWritePost *.coffee silent make!
"エラーがあったら別ウィンドウで表示
autocmd QuickFixCmdPost * nested cwindow | redraw!
nnoremap <Leader>n :CoffeeCompile vert <CR><C-w>h
"}}}

" {{{ vim-coffee-script
"----------------------------------------------------
nnoremap <Leader>el :EvervimNotebookList<CR>
nnoremap <Leader>es :EvervimSearchByQuery<Space>
nnoremap <Leader>ec :EvervimCreateNote<CR>
nnoremap <Leader>et :EvervimListTags<CR>
" }}}
"
" {{{ Syntastic setting for Javascript JSLint
"----------------------------------------------------
"let g:syntastic_javascript_jslint_conf="--maxerr=400 --indent=2 --undef --nomen --regexp --plusplus --bitwise --newcap --sloppy --vars"
"let g:syntastic_mode_map = {
"  \ 'mode': 'active',
"  \ 'active_filetypes': ['javascript', 'json'],
"  \ 'passive_filetypes': ['php'] }
" }}}

" {{{ カラースキームの設定
"----------------------------------------------------
"colorscheme Tomorrow-Night-Bright-Simeji
" solarizedを使う場合
"syntax enable
"set background=dark
"colorscheme solarized
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
