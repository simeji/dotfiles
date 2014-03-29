#
# .zshrc
#
# http://www.crimson-snow.net/tips/unix/zsh.html
# http://www.google.com/notebook/public/18412722587928953882/BDQqFIwoQw7akjLwh


#
# 言語
#
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
#export LANG=ja_JP.eucJP
#export LC_ALL=ja_JP.eucJP
#export LC_CTYPE=ja_JP.eucJP
#export LC_MESSAGES=ja_JP.eucJP

# color
local gray=$'%{\e[0;30m%}'
local red=$'%{\e[0;31m%}'          # 赤色
local green=$'%{\e[0;32m%}'        # 緑色
local yellow=$'%{\e[0;33m%}'       # 黄色
local blue=$'%{\e[0;34m%}'         # 青色
local purple=$'%{\e[0;35m%}'       # 紫色
local light_blue=$'%{\e[0;36m%}'   # 水色
local white=$'%{\e[0;37m%}'        # 白色
local GRAY=$'%{\e[1;30m%}'
local RED=$'%{\e[1;31m%}'          # 赤色
local GREEN=$'%{\e[1;32m%}'        # 緑色
local YELLOW=$'%{\e[1;33m%}'       # 黄色
local BLUE=$'%{\e[1;34m%}'         # 青色
local PURPLE=$'%{\e[1;35m%}'       # 紫色
local LIGHT_BLUE=$'%{\e[1;36m%}'   # 水色
local WHITE=$'%{\e[1;37m%}'        # 白色
local DEFAULT=$white               # 標準の色
#local RANDOM_COLOR=$"%{\e[0;$[31+$RANDOM%6]m%}"

# prompt
PROMPT="$? $GREEN%~$RED $HOSTNAME $GREEN
%(!.#.$)%b $DEFAULT"               # 左表示
RPROMPT="$BLUE `hostname`[ $SSH_AGENT_PID ] $DEFAULT" # 右表示
PROMPT2="%_%%"                     # 複数行入力時
SPROMPT="%r is correct?[n,y]:%"    # 入力ミス時

# そのた
export EDITOR=vim                  # デフォルトのエディタ ?
export LISTMAX=0                   # 補完リストが多い場合に尋ねるか -1:尋ねない, 0:ウインドウから溢れるとき
#export ZDOTDIR=$HOME/.zsh
export TERM=xterm-color

# 全般
bindkey -e                               # emacs のキーバインドを使用
setopt ignoreeof                         # ^D でexit しない。10回連続するとログアウト
export WORDCHARS='*?_.[]~=&;!#$%^(){}<>' # Ctrl+wで､直前の/までを削除する｡
setopt rm_star_silent                    # "rm * " を実行する前に確認
setopt print_eight_bit                   # 日本語を正しく表示
setopt bsd_echo                          # echo を BSD互換に
setopt print_exit_value                  # 戻り値が 0 以外の時は表示する
setopt promptcr                          # 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt beep                            # ベルを鳴らさない
limit coredumpsize 0                     # コアファイルを吐かないようにする
# for debug
#setopt xtrace                            # コマンドラインがどのように実行されたかトレース

# 補完
setopt always_last_prompt       # 補完をしてもプロンプトの位置を変えない
setopt auto_list                # 補完候補が複数あるとき、自動でメニューをリストアップする
setopt auto_menu                # tab,^i で順次補完候補を補完
setopt auto_param_keys          # 変数名を補完する
setopt list_packed              # 補完候補を詰めて表示
setopt list_types               # 補完候補表示時にファイルの種類も表示する *, @, / などが付く
setopt auto_remove_slash        # ディレクトリの後でスペースを入力すると、ディレクトリの後ろに付くスラッシュを削除する
setopt auto_param_slash         # ディレクトリ名の補完で末尾に / を自動的に補完
setopt mark_dirs                # ファイル名展開でディレクトリにマッチすると / をつける
setopt complete_in_word         # 語の途中でもカーソル位置で補完
setopt magic_equal_subst        # --prefix=/usr などの = 以降も補完
setopt hist_verify              # ヒストリから呼び出したときに一度編集できるように
unsetopt list_beep              # 補完の時にベルを鳴らさない
unsetopt auto_pushd             # 移動したディレクトリを補完候補に
unsetopt menu_complete          # 補完候補が複数ある時、すぐに最初の候補を補完する
unsetopt list_rows_first        # 補完の表示順序を水平方向にする
unsetopt complete_aliases       # エイリアスには別の補完規則を適用する
unsetopt correct_all            # 引数についてもスペル修正を試みる(うっとおしい)
autoload -U compinit; compinit  # zshの補完機能を利用する
fignore=(CVS .svn)              # 補完対象外
eval `dircolors ~/.dir_colors`                # 補完候補にも色付き表示
zstyle ':completion:*:default' list-colors ${LS_COLORS}
# 補完の時に大文字小文字を区別しない(但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# sudo も補完対象にする
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
# 補完候補は Emacs のキーバインドで選択
zstyle ':completion:*:default' menu select=1

# 履歴
HISTFILE=$HOME/.zsh_history   # ヒストリを保存するファイル名
HISTSIZE=10000                   # メモリに展開する履歴数
SAVEHIST=30000                   # HISTFILEに保存する履歴数
setopt bang_hist                 # !を使ったヒストリ展開を利用する
setopt extended_history          # 履歴に開始/終了時刻を記録
setopt inc_append_history        # 履歴をインクリメンタルに追加
#setopt hist_ignore_dups          # 同じコマンドを連続して実行したとき、1つしか記録しない
setopt hist_ignore_space         # スペースから始まるものはヒストリに追加しない
setopt hist_reduce_blanks        # ヒストリ記録時に余分なスペースを削除する
#setopt hist_no_store             # history コマンドは記録しない
setopt append_history            # zsh 複数起動時 history ファイルを上書きせず追記
unsetopt share_history           # 複数のzshセッションでヒストリをリアルタイムで共有する
#unsetopt hist_ignore_all_dups    # ヒストリ内に全く同じ行があれば、古い方を削除する
#unsetopt hist_expire_dups_first  # 古いヒストリが削除されるとき、まったく同じ行があれば、それを削除する
#unsetopt hist_save_no_dups       # ヒストリ記録時に、古いコマンドと同じものがあれば削除する
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward


## グロブ
setopt glob                  # ファイルグロブを利用する
setopt extendedglob          # 拡張グロブを利用する
setopt glob_dots             # ドットで始まるファイルもファイルグロブでマッチさせる
setopt case_glob             # 大文字小文字を区別する
setopt numeric_glob_sort     # ファイル名を数字としてソート 1, 10, 2 -> 1, 2, 10
setopt nomatch               # マッチしない場合はエラーにする
setopt mark_dirs             # ファイル名展開でディレクトリだと / を付ける
setopt extended_glob                     # ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt brace_ccl                         # {a-c} を a b c に展開する

## ジョブ制御
setopt auto_resume           # ジョブの頭文字だけで、ジョブの再実行を行う
setopt monitor               # ジョブ制御を可能にする(当たり前というかデフォルト)
setopt bg_nice               # バックグラウンドジョブを低い優先純度で実行する
setopt check_jobs            # zsh終了時に、バックグラウンドジョブや停止中のジョブを表示する
setopt checkjobs             # ログアウト時にバックグラウンドジョブを確認する
unsetopt notify              # バックグラウンドジョブの状態が変化したとき、即座に票時する(無効の場合は次のプロンプトで表示)
setopt no_hup                # ログアウト時にバックグラウンドジョブをkillしない
# setopt long_list_jobs

## プロンプト
setopt prompt_subst                  # プロンプト定義内で変数置換や、コマンド置換を行う
setopt prompt_percent                # プロンプト定義内で % を特殊文字として扱う
setopt prompt_bang                   # プロンプト定義内で ! を特殊文字として扱う
setopt transient_rprompt             # 最新の行のみ右プロンプトを表示する
## ディレクトリ
setopt auto_cd               # ディレクトリ名だけで移動:w
setopt chase_links           # 移動先がシンボリックリンクなら実際のディレクトリに移動する(好みが分かれるかも)
setopt pushd_ignore_dups     # ディレクトリスタックに重複するディレクトリを登録しない
setopt autopushd             # cd -<tab> で pushd　で入れたディレクトリに移動できる

## 入出力
setopt aliases               # エイリアス、拡張エイリアスを利用する
setopt clobber               # 既存のファイルにリダイレクトで上書きするのを認める
setopt correct               # コマンド名のスペル修正を試みる
setopt ignore_eof            # Ctrl+d によるログアウト抑制(10回目でログアウト)
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
# hash_cmds
# hash_dirs
# path_dirs


# aliases
alias ll="/bin/ls"
alias ls="ll -al --show-control-chars --color=auto -F"
alias jobs='jobs -l'
alias sc='screen'


# .zshfunctions
# ディレクトリを移動するときに実行
cdpwd() {
}

# プロンプトが表示される前に実行
precmd() {
builtin jobs | wc -l | read jobcount
[ "x0" != "x$jobcount" ]      && jobcount=$jobcount       || jobcount=-
[ "x"  != "x$SSH_AGENT_PID" ] && ssh_agent=$SSH_AGENT_PID || ssh_agent=-
ip=`LANG=C /sbin/ifconfig eth0 | grep 'inet addr' | awk -F: '{print $2}' | awk '{print $1}'`
PROMPT="$? $BLUE [$PURPLE$USER@$ip$BLUE] $GREEN%~$GRAY $HOSTNAME $GREEN
%(!.#.$)%b $DEFAULT"               # 左表示
RPROMPT="$YELLOW `hostname` $BLUE [$YELLOW$jobcount$BLUE:$YELLOW$ssh_agent$BLUE] `date "+%Y/%m/%d %H:%M"` $DEFAULT" # 右表示
}

#
# funcitons
# ---

# zsh の設定を反映させる
function reload() {
    source $HOME/.zshrc
}

# ssh agent を起動する
function ssha() {
    if [ -z "$SSH_AGENT_PID" ]; then
        eval `ssh-agent`;
        ssh-add;
    fi
}

# ssh agent を kill する
function exit() {
    if [ -n "$SSH_AGENT_PID" ]; then
        eval `ssh-agent -k`
    fi
    builtin exit
}

# vim 用の neco プラグインをアップデートする
function updateNeco() {
    curl -L http://github.com/Shougo/neocomplcache/tarball/master | tar -xzC ~/.vim --strip-components=1 --exclude=presen
}
#rvm用
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -s "/usr/local/rvm/scripts/rvm" ]] && . "/usr/local/rvm/scripts/rvm"


# 独自環境用拡張
[[ -s "$HOME/.zshrc.local" ]] && . "$HOME/.zshrc.local"
